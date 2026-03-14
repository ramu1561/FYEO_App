//
//  Coordinator.swift
//  FYEO
//
//  Created by Harvi Jivani on 11/03/26.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject{
    var navigationController: UINavigationController { get set}
    func start()
}
