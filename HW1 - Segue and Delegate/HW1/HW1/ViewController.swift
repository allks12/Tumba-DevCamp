//
//  ViewController.swift
//  HW1
//
//  Created by Aleksandra on 23.07.23.
//

import UIKit

class ViewController: UIViewController, SecondViewControllerDelegate {
    
    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var firstNameInputView: InputView!
    @IBOutlet weak var lastNameInputView: InputView!
    @IBOutlet weak var emailInputView: InputView!
    @IBOutlet weak var passwordInputView: InputView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SecondViewController else {
            return
        }
        
        destinationVC.delegate = self
        destinationVC.profile.firstName = firstNameInputView?.textField.text ?? ""
        destinationVC.profile.lastName = lastNameInputView?.textField.text ?? ""
        destinationVC.profile.email = emailInputView.textField.text ?? ""
        destinationVC.profile.password = passwordInputView.textField.text ?? ""
    }
    
    func resetProfile() {
        firstNameInputView.textField.text = ""
        lastNameInputView.textField.text = ""
        emailInputView.textField.text = ""
        passwordInputView.textField.text = ""
    }
    
    func setUp() {
        formBackgroundView.layer.borderWidth = 2
        formBackgroundView.layer.borderColor = UIColor(named: "CustomBlue")?.cgColor
        
        firstNameInputView.label.text = "First Name"
        lastNameInputView.label.text = "Last Name"
        emailInputView.label.text = "Email (Login ID)"
        passwordInputView.label.text = "Password"
        passwordInputView.textField.isSecureTextEntry = true
        submitButton.backgroundColor = UIColor(named: "CustomBlue")
        submitButton.tintColor = UIColor(named: "CustomBlue")
        
        title = "Create Account"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        let bellButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        navigationItem.setRightBarButtonItems([bellButton, searchButton], animated: true)
    }

    @IBAction func toggleCheckBox(_ sender: UIButton) {
        print(checkBoxButton.imageView ?? "hhhh")
        if checkBoxButton.image(for: .normal) == UIImage(systemName: "checkmark.square") {
            checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        if sender.image(for: .normal) == UIImage(systemName: "eye.slash") {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordInputView.textField.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordInputView.textField.isSecureTextEntry = true
        }
    }
}

