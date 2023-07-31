//
//  HomeViewController.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import UIKit

class HomeViewController: UIViewController {
    var homeCoordinator: HomeCoordinator
    
    init?(coder: NSCoder, homeCoordinator: HomeCoordinator) {
        self.homeCoordinator = homeCoordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
    }

    @IBAction func showGreeting(_ sender: UIButton) {
        homeCoordinator.showGreeting()
    }
}
