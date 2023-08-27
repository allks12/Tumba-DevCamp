//
//  CreateExpenseCoordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class CreateExpenseCoordinator: BaseCoordinator {
    var index: Int?

    override func start() {
        guard let index else {
            return
        }
        let createExpenseVC = CreeateExpenseViewController(for: index, coordinator: self)
        let navController = UINavigationController(rootViewController: createExpenseVC)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }

    func cancel() {
        navigationController.dismiss(animated: true)
    }

    func submit() {
        navigationController.dismiss(animated: true)
    }
}
