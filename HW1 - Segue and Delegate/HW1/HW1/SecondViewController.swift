//
//  SecondViewController.swift
//  HW1
//
//  Created by Aleksandra on 24.07.23.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    weak var delegate: SecondViewControllerDelegate?
    
    var profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        firstNameLabel.text = profile.firstName
        lastNameLabel.text = profile.lastName
        emailLabel.text = profile.email
        passwordLabel.text = profile.password
    }
    
    func setUp() {
        resetButton.backgroundColor = UIColor(named: "CustomBlue")
        resetButton.tintColor = UIColor(named: "CustomBlue")
    }

    @IBAction func resetAction(_ sender: UIButton) {
        delegate?.resetProfile()
    }
}

protocol SecondViewControllerDelegate: AnyObject {
    func resetProfile()
}
