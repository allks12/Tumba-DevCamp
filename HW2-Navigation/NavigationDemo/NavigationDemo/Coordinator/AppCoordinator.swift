//
//  AppCoordinator.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import Foundation
import UIKit

class AppCoordinator: NSObject, Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") { coder in
            let homeCoordinator = HomeCoordinator(parentCoordinator: self,
                                                  navigationController: self.navigationController)
            
            self.addChild(child: homeCoordinator)
            
            return HomeViewController(coder: coder,
                                      homeCoordinator: homeCoordinator)
        }

        let profileVC = storyboard.instantiateViewController(identifier: "ProfileViewController") {
            coder in
            let profileCoordinator = ProfileCoordinator(parentCoordinator: self,
                                                        navigationController: self.navigationController)
            
            self.addChild(child: profileCoordinator)
            
            return ProfileViewController(coder: coder,
                                         profileCoordinator: profileCoordinator)
        }
        
        configureTabBar(viewControllers: [homeVC, profileVC])
        
        childCoordinators.forEach {
            $0.start()
        }
    }
    
    func configureTabBar(viewControllers: [UIViewController]) {
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        
        for controller in viewControllers {
            let tabBarItem: UITabBarItem
            switch controller {
            case is HomeViewController:
                tabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"), tag: 0)
            case is ProfileViewController:
                tabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(systemName: "person"), tag: 1)
            default:
                tabBarItem = UITabBarItem()
            }
            controller.tabBarItem = tabBarItem
        }
        
        tabBarController.viewControllers = viewControllers
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

extension AppCoordinator: UITabBarControllerDelegate {
    func tabBarController(_: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case is HomeViewController:
            navigationController.navigationBar.topItem?.title = "Home"
        case is ProfileViewController:
            navigationController.navigationBar.topItem?.title = "Profile"
        default:
            break
        }
    }
}
