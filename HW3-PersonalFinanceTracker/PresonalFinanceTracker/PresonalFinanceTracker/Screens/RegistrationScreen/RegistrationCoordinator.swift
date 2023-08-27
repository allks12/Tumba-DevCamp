//
//  RegistrationCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

class RegistrationCoordinator: BaseCoordinator {
    
    override func start() {
        let registrationVC = RegistrationViewController(coordinator: self)
        let navController = UINavigationController(rootViewController: registrationVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
}
