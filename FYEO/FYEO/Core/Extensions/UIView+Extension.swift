//
//  UIView+Extension.swift
//  FYEO
//
//  Created by Harvi Jivani on 13/03/26.
//

import UIKit

extension UIView {
    static func loadFromNib<T: UIView>() -> T {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! T
    }
}
