//
//  SignInViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 25/01/26.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var emailOrPhoneTextField: AppTextField!
    @IBOutlet weak var passwordTextField: AppTextField!
    var coordinator: AuthCoordinator?//For redirection logics
    var viewModel: SignInViewModel?
    var fields:[AppTextField] = []
    
    override var shouldShowHeader: Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        AppShield.shared.start()
        bindViewModel()
    }
    
    func setupUI(){
        fields = [emailOrPhoneTextField, passwordTextField]
        
        emailOrPhoneTextField.validationType = .required
        passwordTextField.validationType = .required
    }
    
    private func bindViewModel() {
        viewModel?.onLoading = { [weak self] loading in
            self?.showLoader(loading)
        }
        
        viewModel?.onLoginSuccess = {
            print("Verify phone/email")
            guard let phoneFieldText = self.emailOrPhoneTextField.text else{
                return
            }
            self.coordinator?.showVerifyScreen(phoneOrEmail: self.emailOrPhoneTextField.text ?? "", isEmail: phoneFieldText.isEmail,isFromRegistration: false)
        }
        
        viewModel?.onError = { error in
            //temporary check
            if error == "Phone number not verified"{
                guard let phoneFieldText = self.emailOrPhoneTextField.text else{
                    return
                }
                self.coordinator?.showVerifyScreen(phoneOrEmail: self.emailOrPhoneTextField.text ?? "", isEmail: phoneFieldText.isEmail,isFromRegistration: true)
            }
            else{
                self.showToast(message: error)
            }
        }
    }
    //MARK: - Button Actions
    @IBAction func toggleButtons(_ sender: UIButton) {
        if sender.tag == 1{
            //x
            coordinator?.showSignInOptionsScreen()
        }
        else if sender.tag == 2{
            //google
        }
        else if sender.tag == 3{
            //Venmo
        }
        else{
            //Sign in
            //self.coordinator?.showVerifyScreen(phoneOrEmail: self.emailOrPhoneTextField.text ?? "", isEmail: false,isFromRegistration: true)
            
            
            if (viewModel?.validateForm(fields: self.fields) ?? false){
                viewModel?.loginWith(phone: self.emailOrPhoneTextField.text ?? "", password: self.passwordTextField.text ?? "")
            }
            
        }
    }
}
