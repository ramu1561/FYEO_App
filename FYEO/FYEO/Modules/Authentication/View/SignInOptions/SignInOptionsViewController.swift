//
//  SignInOptionsViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 26/01/26.
//

import UIKit

class SignInOptionsViewController: BaseViewController {
    
    var coordinator:AuthCoordinator?
    
    @IBOutlet weak var continueButton:UIButton!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    override var shouldShowHeader: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleContinue(_ sender: UIButton){
        
    }
}
