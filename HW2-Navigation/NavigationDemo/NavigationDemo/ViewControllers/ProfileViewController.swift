//
//  ProfileViewController.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import UIKit

class ProfileViewController: UIViewController {
    var profileCoordinator: ProfileCoordinator
    
    init?(coder: NSCoder, profileCoordinator: ProfileCoordinator) {
        self.profileCoordinator = profileCoordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
    }

}
