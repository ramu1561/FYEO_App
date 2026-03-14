//
//  BaseViewController.swift
//  FYEO
//
//  Created by Harvi Jivani on 13/03/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    var headerView: CustomNavigationView!
    // Control header visibility
    var shouldShowHeader: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        if shouldShowHeader {
            setupNavigationBar()
        }
    }
    private func setupNavigationBar() {
        headerView = CustomNavigationView.loadFromNib()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        headerView.backAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    func showLoader(_ isLoading:Bool) {
        if isLoading{
            LoaderView.shared.show(on: self.view)
        }
        else{
            LoaderView.shared.hide()
        }
    }
}
