//
//  RegistrationCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

class RegistrationCoordinator: BaseCoordinator {
    var registrationDelegate: RegistrationDelegate
    
    init(parentCoordinator: Coordinator,
        navigationController: UINavigationController,
        registrationDelegate: RegistrationDelegate) {
        self.registrationDelegate = registrationDelegate
        super.init(parentCoordinator: parentCoordinator,
                   navigationController: navigationController)
    }
    
    override func start() {
        let registrationVC = RegistrationViewController(coordinator: self,
                                                        delegate: registrationDelegate)
        let navController = UINavigationController(rootViewController: registrationVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
}
