//
//  UIViewController+Toast.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//

import Foundation
import UIKit

extension UIViewController {

    func showToast(message: String) {

        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = .white
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true

        let padding: CGFloat = 16
        let maxWidth = view.frame.width - 40

        let size = toastLabel.sizeThatFits(
            CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        )

        toastLabel.frame = CGRect(
            x: (view.frame.width - size.width - padding) / 2,
            y: view.frame.height - 120,
            width: size.width + padding,
            height: size.height + padding
        )

        view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.5) {
            toastLabel.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            UIView.animate(withDuration: 0.5, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }

        }
    }
}
