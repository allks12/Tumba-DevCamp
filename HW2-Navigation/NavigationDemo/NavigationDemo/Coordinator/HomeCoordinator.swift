//
//  HomeCoordinator.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
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
    
    func showGreeting() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let greetingVC = storyboard.instantiateViewController(identifier: "GreetingViewController") { coder in
            let greetingCoordinator = GreetingCoordinator(parentCoordinator: self, navigationController: self.navigationController)
            
            self.addChild(child: greetingCoordinator)
            
            return GreetingViewController(coder: coder, greetingCoordinator: greetingCoordinator)
        }
        
        navigationController.pushViewController(greetingVC, animated: true)
    }
}
