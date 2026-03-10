//
//  AppShield.swift
//  FYEO
//
//
//

import Foundation
import AVFoundation
import FaceSDK


class AppShield: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    

    // MARK: - Properties
    private let session = AVCaptureSession()
    private let cameraQueue = DispatchQueue(label: "camera.queue", qos: .userInteractive)
    private let processingQueue = DispatchQueue(label: "regula.processing.queue", qos: .userInteractive)
    
    // Optimization: Disable color management for 15% faster rendering
    private let sharedContext = CIContext(options: [
        .useSoftwareRenderer: false,
        .workingColorSpace: NSNull()
    ])
    
    private var masterMatchImage: MatchFacesImage?
    private var isProcessing = false
    private var blurView: UIVisualEffectView?
    private let statusLabel = UILabel()
    private let lockIcon = UIImageView()
    private var lastProcessTime = Date(timeIntervalSince1970: 0)
    private let faceFileName = "app.bio.png"
    private var isIntialized = false
    
    private let similarityThreshold: Float = 0.85
        
    static let shared = AppShield()
    
    var view: UIView {
        UIApplication.shared.windows.last ?? UIView()
    }
    
    private override init() {
        // Prevent external initialization
    }
    
    func isInitialized() -> Bool {
        return isIntialized
    }

    func start() {
        if false == isFaceEnrolled() {
            return
        }
        
        FaceSDK.service.initialize { [weak self] success, _ in
            if success {
                self?.prepareReferenceImage()
                // Forced pre-warm
                let dummy = MatchFacesImage(image: UIImage(), imageType: .printed)
                FaceSDK.service.matchFaces(MatchFacesRequest(images: [dummy, dummy]), configuration: MatchFacesConfiguration { $0.processingMode = .offline }) { _ in }
            }
        }
        
        setupStatusUI()
        applyLockUI()
        DispatchQueue.global(qos: .userInitiated).async { self.startCamera() }
        isIntialized = true
    }
    
    func pause() {
        session.stopRunning()
    }
    
    func resume() {
        session.startRunning()
    }

    private func prepareReferenceImage() {
        guard let originalImage = loadFaceImage() else { return }
        // 250px is the sweet spot for the fastest landmark alignment
        let scaledSize = CGSize(width: 250, height: 250 * (originalImage.size.height / originalImage.size.width))
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: scaledSize, format: format)
        let readyImage = renderer.image { _ in originalImage.draw(in: CGRect(origin: .zero, size: scaledSize)) }
        self.masterMatchImage = MatchFacesImage(image: readyImage, imageType: .printed)
    }

    private func processFrame(pixelBuffer: CVPixelBuffer) {
        // Short-circuit: If the NPU is busy, don't even look at the frame
        guard !isProcessing, let master = masterMatchImage else { return }
        isProcessing = true
        
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)

        processingQueue.async { [weak self] in
            guard let self = self else { return }
            
            // Render directly to CGImage - No UIImage wrappers until necessary
            guard let cgImage = self.sharedContext.createCGImage(ciImage, from: CGRect(x: 0, y: 0, width: width, height: height)) else {
                self.isProcessing = false
                return
            }
            
            let request = MatchFacesRequest(images: [master, MatchFacesImage(image: UIImage(cgImage: cgImage), imageType: .live)])
            
            FaceSDK.service.matchFaces(request, configuration: MatchFacesConfiguration { $0.processingMode = .offline }) { [weak self] response in
                guard let self = self else { return }
                
                let similarity = response.results.first?.similarity?.floatValue ?? 0.0
                
                DispatchQueue.main.async {
                    if similarity > self.similarityThreshold {
                        self.removeLockUI()
                    } else {
                        self.applyLockUI()
                    }
                    self.isProcessing = false
                }
            }
        }
    }

    // MARK: - UI Configuration (Minimalist/Snappy)
    private func setupStatusUI() {
        [statusLabel, lockIcon].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; view.addSubview($0) }
        statusLabel.font = .systemFont(ofSize: 20, weight: .bold)
        NSLayoutConstraint.activate([
            lockIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lockIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            lockIcon.widthAnchor.constraint(equalToConstant: 60), lockIcon.heightAnchor.constraint(equalToConstant: 60),
            statusLabel.topAnchor.constraint(equalTo: lockIcon.bottomAnchor, constant: 15),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        guard blurView == nil else { return }
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blur.frame = view.bounds
        view.insertSubview(blur, belowSubview: lockIcon)
        blurView = blur
    }

    private func applyLockUI() {
//        statusLabel.text = "MONITORING"; statusLabel.textColor = .systemRed
        blurView?.isHidden = false
        statusLabel.isHidden = true
        lockIcon.isHidden = false
        lockIcon.image = UIImage(systemName: "lock.shield.fill"); lockIcon.tintColor = .systemRed
        view.bringSubviewToFront(lockIcon)
    }

    private func removeLockUI() {
        lockIcon.isHidden = true
        self.blurView?.isHidden = true 
//        guard let b = blurView else { return }
//        b.removeFromSuperview();
//        self.blurView = nil
        // 0.1s is the limit of human perception for "instant"
//        UIView.animate(withDuration: 0.1, animations: {
//            b.alpha = 0; self.statusLabel.text = "AUTHORIZED"; self.statusLabel.textColor = .systemGreen
//            self.lockIcon.image = UIImage(systemName: "lock.open.fill"); self.lockIcon.tintColor = .systemGreen
//        }) { _ in b.removeFromSuperview(); self.blurView = nil }
    }

    private func startCamera() {
        session.sessionPreset = .vga640x480
        guard let dev = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: dev) else { return }
        session.addInput(input)
        let out = AVCaptureVideoDataOutput()
        out.alwaysDiscardsLateVideoFrames = true
        out.setSampleBufferDelegate(self, queue: cameraQueue)
        session.addOutput(out)
        session.startRunning()
        out.connection(with: .video)?.videoOrientation = .portrait
        out.connection(with: .video)?.isVideoMirrored = true
    }

    func captureOutput(_ o: AVCaptureOutput, didOutput s: CMSampleBuffer, from c: AVCaptureConnection) {
        let now = Date()
        // 0.4s is the most a mobile device can handle without thermal throttling over time
        guard now.timeIntervalSince(lastProcessTime) > 0.4,
              let pb = CMSampleBufferGetImageBuffer(s) else { return }
        lastProcessTime = now
        processFrame(pixelBuffer: pb)
    }
    
}

extension AppShield {
    private func faceImageURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(faceFileName)
        return fileURL
    }
    
    func saveFaceLocally(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return }

        let fileURL = faceImageURL()
        do {
            try data.write(to: fileURL)
            print("Image saved at:", fileURL)
        } catch {
            print("Error saving image:", error)
        }
    }
    
    func isFaceEnrolled() -> Bool {
        let fileURL = faceImageURL()
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    func loadFaceImage() -> UIImage? {
        let fileURL = faceImageURL()
        return UIImage(contentsOfFile: fileURL.path)
    }
}
