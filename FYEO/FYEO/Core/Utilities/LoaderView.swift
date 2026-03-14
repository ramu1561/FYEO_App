//
//  LoaderView.swift
//  FYEO
//
//  Created by Harvi Jivani on 12/03/26.
//

import UIKit


import UIKit

class LoaderView {

    static let shared = LoaderView()

    private var spinner = UIActivityIndicatorView(style: .large)
    private var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()

    func show(on view: UIView) {
        DispatchQueue.main.async {
            view.isUserInteractionEnabled = false
            
            self.overlayView.frame = view.bounds
            self.overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.spinner.center = CGPoint(x: self.overlayView.bounds.midX,
                                          y: self.overlayView.bounds.midY)
            self.spinner.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin,
                                             .flexibleTopMargin, .flexibleBottomMargin]
            
            self.overlayView.addSubview(self.spinner)
            view.addSubview(self.overlayView)
            
            self.spinner.startAnimating()
        }
    }

    func hide() {
        DispatchQueue.main.async {
            self.overlayView.superview?.isUserInteractionEnabled = true
            
            self.spinner.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
}


//Without dimmer effect
/*
class LoaderView {

    static let shared = LoaderView()

    private var spinner = UIActivityIndicatorView(style: .large)

    func show(on view: UIView) {
        DispatchQueue.main.async {
            
            view.isUserInteractionEnabled = false
            
            self.spinner.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            self.spinner.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
            
            self.spinner.startAnimating()
            view.addSubview(self.spinner)
        }
    }

    func hide() {
        DispatchQueue.main.async {
            self.spinner.superview?.isUserInteractionEnabled = true
            
            self.spinner.stopAnimating()
            self.spinner.removeFromSuperview()
        }
    }
}
*/
