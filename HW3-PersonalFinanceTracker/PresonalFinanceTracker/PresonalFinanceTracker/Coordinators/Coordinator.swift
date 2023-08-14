//
//  Coordinator.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    func addChild(child: Coordinator)
    func addChildren(children: [Coordinator])
    func removeChild(child: Coordinator)
}

extension Coordinator {
    func addChild(child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func addChildren(children: [Coordinator]) {
        childCoordinators.append(contentsOf: children)
    }
    
    func removeChild(child: Coordinator) {
        childCoordinators = childCoordinators.filter {
            $0 !== child
        }
    }
}
