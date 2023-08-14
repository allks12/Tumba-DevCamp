//
//  AccountCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

class AccountCoordinator: BaseCoordinator {
    private var accountDelegate: AccountDelegate
    
    init(parentCoordinator: Coordinator,
         navigationController: UINavigationController,
         delegate: AccountDelegate) {
        self.accountDelegate = delegate
        super.init(parentCoordinator: parentCoordinator,
                   navigationController: navigationController)
    }
    
    override func start() {
        let accountVC = AccountViewController(coordinator: self, delegate: accountDelegate)
        let navController = UINavigationController(rootViewController: accountVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
}
