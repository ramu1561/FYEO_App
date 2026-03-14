//
//  String+Extension.swift
//  FYEO
//
//  Created by Harvi Jivani on 13/03/26.
//

import Foundation

extension String {
    
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    var isPhoneNumber: Bool {
        let phoneRegex = "^\\+?[0-9]{10,14}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self)
    }
}
