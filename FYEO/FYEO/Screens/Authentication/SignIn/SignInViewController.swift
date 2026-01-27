//
//  SignInViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 25/01/26.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //MARK: - Button Actions
    @IBAction func toggleButtons(_ sender: UIButton) {
        if sender.tag == 1{
            //x
            guard let optionsVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: String(describing: SignInOptionsViewController.self)) as? SignInOptionsViewController else {
                return
            }
            navigationController?.pushViewController(optionsVC, animated: true)
        }
        else if sender.tag == 2{
            //google
        }
        else if sender.tag == 3{
            //Venmo
        }
        else{
            //Sign in
            guard let verifyVC = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(withIdentifier: String(describing: VerifyAuthViewController.self)) as? VerifyAuthViewController else {
                return
            }
            navigationController?.pushViewController(verifyVC, animated: true)
        }
    }
}
