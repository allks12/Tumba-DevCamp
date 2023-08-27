//
//  AppCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = MainViewController(coordinator: self)
        navigationController.pushViewController(mainVC, animated: true)
    }

    func loadDetails(for accountIndex: Int) {
        let coordinator = AccountDetailsCoordinator(parentCoordinator: self,
                                                    navigationController: navigationController)
        coordinator.index = accountIndex
        addChild(child: coordinator)
        coordinator.start()
    }
}
