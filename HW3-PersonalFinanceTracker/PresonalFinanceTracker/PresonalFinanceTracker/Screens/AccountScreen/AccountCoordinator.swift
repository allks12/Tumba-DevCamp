//
//  AccountCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

class AccountCoordinator: BaseCoordinator {

    override func start() {
        let accountVC = AccountViewController(coordinator: self)
        let navController = UINavigationController(rootViewController: accountVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
}
