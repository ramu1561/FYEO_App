//
//  OTPTextField.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//


import UIKit

class OTPTextField: UITextField {

    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?

    override func deleteBackward() {
        if text?.isEmpty ?? true {
            previousTextField?.becomeFirstResponder()
        }
        super.deleteBackward()
    }
}