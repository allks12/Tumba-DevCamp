//
//  GreetingViewController.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import UIKit
import Combine

class GreetingViewController: UIViewController {
    var greetingCoordinator: GreetingCoordinator
    @IBOutlet weak var nameLabel: UILabel!
    var subscription: AnyCancellable?
    
    init?(coder: NSCoder, greetingCoordinator: GreetingCoordinator) {
        self.greetingCoordinator = greetingCoordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Greeting"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addName))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @IBAction func addName(_ sender: UIButton) {
        let nameVC = greetingCoordinator.showName()
        
        subscription = nameVC.userName.sink { name in
            print(name)
            self.nameLabel.text = "\(name)!"
            self.nameLabel.textColor = UIColor.systemPink
        }
    }

}
