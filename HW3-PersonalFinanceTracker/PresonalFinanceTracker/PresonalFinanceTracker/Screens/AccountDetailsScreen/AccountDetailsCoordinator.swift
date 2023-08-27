//
//  AccountDetailsCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class AccountDetailsCoordinator: BaseCoordinator {
    var index: Int?

    override func start() {
        guard let index else {
            return
        }
        let detailsVC = AccountDetailsViewController(for: index, coordinator: self)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
