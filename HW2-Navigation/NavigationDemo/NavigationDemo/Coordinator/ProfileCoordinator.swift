//
//  ProfileCoordinator.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator]
    
    var navigationController: UINavigationController
    
    init(parentCoordinator: Coordinator,
         navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
    }
    
    
}
