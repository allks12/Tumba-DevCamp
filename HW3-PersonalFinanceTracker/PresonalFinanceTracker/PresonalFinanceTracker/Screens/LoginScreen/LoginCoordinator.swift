//
//  LoginCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

class LoginCoordinator: BaseCoordinator {
    var loginDelegate: LoginDelegate
    
    init(parentCoordinator: Coordinator,
                  navigationController: UINavigationController,
                  loginDelegate: LoginDelegate) {
        self.loginDelegate = loginDelegate
        super.init(parentCoordinator: parentCoordinator,
                   navigationController: navigationController)
    }
    
    override func start() {
        let loginVC = LoginViewController(coordinator: self,
                                          delegate: loginDelegate)
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
}
