//
//  AuthCoordinator.swift
//  FYEO
//
//  Created by Harvi Jivani on 11/03/26.
//

import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSignInScreen()
    }
    
    func showSignInScreen() {
        let vc = UIStoryboard.authentication()
            .instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as! SignInViewController
        vc.coordinator = self
        vc.viewModel = SignInViewModel()
        //navigationController.setViewControllers([vc], animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showVerifyScreen(phoneOrEmail: String, isEmail: Bool, isFromRegistration:Bool) {
        guard let verifyVC = UIStoryboard.authentication()
            .instantiateViewController(withIdentifier: String(describing: VerifyAuthViewController.self)) as? VerifyAuthViewController else { return }
        verifyVC.coordinator = self
        verifyVC.viewModel = VerifyAuthViewModel()
        verifyVC.verifyData = (phoneOrEmail,isEmail,isFromRegistration)
        navigationController.pushViewController(verifyVC, animated: true)
    }
    
    func showFaceIDScreen() {
        guard let faceCaptureVC = UIStoryboard.authentication()
            .instantiateViewController(withIdentifier: String(describing: FaceCaptureViewController.self)) as? FaceCaptureViewController else { return }
        
        faceCaptureVC.coordinator = self
        navigationController.pushViewController(faceCaptureVC, animated: true)
    }
    
    func showSignInOptionsScreen(){
        guard let optionsVC = UIStoryboard.authentication().instantiateViewController(withIdentifier: String(describing: SignInOptionsViewController.self)) as? SignInOptionsViewController else {
            return
        }
        optionsVC.coordinator = self
        navigationController.pushViewController(optionsVC, animated: true)
    }
    
    func showConnectFriendsScreen(){
        guard let friendsVC = UIStoryboard.authentication().instantiateViewController(withIdentifier: String(describing: ConnectViewController.self)) as? ConnectViewController else {
            return
        }
        navigationController.pushViewController(friendsVC, animated: true)
    }
}
