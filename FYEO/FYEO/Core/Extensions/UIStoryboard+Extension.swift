//
//  UIStoryboard+Extension.swift
//  FYEO
//
//  Created by Harvi Jivani on 11/03/26.
//

import Foundation
import UIKit

extension UIStoryboard{
    
    static func authentication() -> UIStoryboard {
        return UIStoryboard(name: "Authentication", bundle: nil)
    }
    
    static func chat() -> UIStoryboard {
        return UIStoryboard(name: "Chat", bundle: nil)
    }
    
    static func feed() -> UIStoryboard {
        return UIStoryboard(name: "Feed", bundle: nil)
    }
    
}
