//
//  GreetingCoordinator.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import Foundation
import UIKit

class GreetingCoordinator: Coordinator {
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
    
    func showName() -> NameViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let nameVC = storyboard.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
        
        navigationController.pushViewController(nameVC, animated: true)
        
        return nameVC
    }
}
