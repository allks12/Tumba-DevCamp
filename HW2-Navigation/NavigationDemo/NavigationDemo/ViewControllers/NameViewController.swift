//
//  NameViewController.swift
//  NavigationDemo
//
//  Created by Aleksandra on 24.07.23.
//

import UIKit
import Combine

class NameViewController: UIViewController {
    let userName = PassthroughSubject<String, Never>()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.systemPink
    }

    @IBAction func changeName(_ sender: UIButton) {
        userName.send(nameTextField.text ?? "")
    }
}
