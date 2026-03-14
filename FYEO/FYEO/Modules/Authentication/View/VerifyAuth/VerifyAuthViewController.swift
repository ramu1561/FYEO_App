//
//  VerifyAuthViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 25/01/26.
//

import UIKit

class VerifyAuthViewController: BaseViewController {
    
    var coordinator:AuthCoordinator?
    var verifyData: (phoneOrEmail: String, isEmail: Bool, isFromRegistration:Bool)?
    @IBOutlet weak var lblPhoneOrEmail: UILabel!
    @IBOutlet weak var lblVerifyTitle: UILabel!
    
    @IBOutlet weak var otpContainer: UIView!
    private var otpView: OTPView!
    @IBOutlet weak var verifyButton: UIButton!
    
    var viewModel:VerifyAuthViewModel?
    
    override var shouldShowHeader: Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
        
        //viewModel?.sendOtpAPI(phone: verifyData?.phoneOrEmail ?? "")
    }
    func setupUI(){
        updateVerifyButton(isEnabled: false)
        if verifyData?.isEmail ?? false{
            self.lblVerifyTitle.text = "Verify Email"
        }
        else{
            self.lblVerifyTitle.text = "Verify Phone"
        }
        self.lblPhoneOrEmail.text = verifyData?.phoneOrEmail ?? ""
        
        //OTP view setup
        otpView = OTPView(digits: 6)
        otpView.translatesAutoresizingMaskIntoConstraints = false
        
        otpContainer.addSubview(otpView)
        
        NSLayoutConstraint.activate([
            otpView.topAnchor.constraint(equalTo: otpContainer.topAnchor),
            otpView.bottomAnchor.constraint(equalTo: otpContainer.bottomAnchor),
            otpView.leadingAnchor.constraint(equalTo: otpContainer.leadingAnchor),
            otpView.trailingAnchor.constraint(equalTo: otpContainer.trailingAnchor)
        ])
        
        otpView.otpChanged = { otp in
            print("OTP:", otp)
            self.updateVerifyButton(isEnabled: otp.count == self.otpView.digits)
        }
    }
    private func bindViewModel() {
        viewModel?.onLoading = { [weak self] loading in
            self?.showLoader(loading)
        }
        
        viewModel?.onVerifySuccess = {
            print("Success")
            //Move to required screen
            self.coordinator?.showConnectFriendsScreen()
        }
        
        viewModel?.onError = { error in
            self.otpView.showError()
            self.showToast(message: error)
            
            self.coordinator?.showConnectFriendsScreen()
        }
    }
    func updateVerifyButton(isEnabled: Bool) {
        verifyButton.isEnabled = isEnabled
        verifyButton.alpha = isEnabled ? 1 : 0.5
    }
    
    //MARK: - Button Actions
    @IBAction func toggleButtons(_ sender: UIButton) {
        if sender.tag == 1{
            //resend
            print("resend")
            otpView.clearOTP()
            self.view.endEditing(true)
            viewModel?.loginSendOtpAPI(phone: verifyData?.phoneOrEmail ?? "")
        }
        else if sender.tag == 2{
            //verify
            //coordinator?.showFaceIDScreen()
            let otp = otpView.getOTP()
            print("Verify OTP:", otp)
        
            if (verifyData?.isFromRegistration ?? false){
                viewModel?.verifyRegistrationAPI(phone: verifyData?.phoneOrEmail ?? "", otp: otp)
            }
            else{
                
            }
            
        }
        else{
            //Back
            self.navigationController?.popViewController(animated: true)
        }
    }
}
