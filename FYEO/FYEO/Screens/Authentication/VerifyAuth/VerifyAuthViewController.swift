//
//  VerifyAuthViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 25/01/26.
//

import UIKit

class VerifyAuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    //MARK: - Button Actions
    @IBAction func toggleButtons(_ sender: UIButton) {
        if sender.tag == 1{
            //verify
        }
        else if sender.tag == 2{
            //resend
        }
        else{
            //Back
            self.navigationController?.popViewController(animated: true)
        }
    }
}
