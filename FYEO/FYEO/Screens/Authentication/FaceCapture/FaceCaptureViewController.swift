//
//  FaceCaptureViewController.swift
//  FYEO
//
//
//

import UIKit
import AVFoundation

class FaceCaptureViewController: UIViewController {
    
    @IBOutlet weak var captureBGView: UIView!
    @IBOutlet weak var confirmationBGView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var captureShownImageView: UIImageView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput: AVCapturePhotoOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        captureBGView.isHidden = false
        confirmationBGView.isHidden = true
        setupCamera()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.layer.cornerRadius = cameraView.bounds.width / 2
        cameraView.layer.masksToBounds = true
        previewLayer?.frame = cameraView.bounds
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                        for: .video,
                                                        position: .front),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice)
        else { return }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = cameraView.bounds
        cameraView.layer.addSublayer(previewLayer)
        
                
        let sessionQueue = DispatchQueue(label: "camera.session.queue")

        sessionQueue.async {
            self.captureSession.startRunning()
        }
        
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func captureButtonAction(_ sender: Any) {
        captureBGView.isHidden = true
        confirmationBGView.isHidden = false
        
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        if false == AppShield.shared.isInitialized() {
            AppShield.shared.start()
        }
    }
}

extension FaceCaptureViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        captureShownImageView.image = image
        
        AppShield.shared.saveFaceLocally(image: image)
    }
}

