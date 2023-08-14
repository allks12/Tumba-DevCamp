//
//  RegistrationViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func saveCurrentUser(registeredUser: User)
}

class RegistrationViewController: UIViewController {
    private let coordinator: RegistrationCoordinator
    weak var delegate: RegistrationDelegate?
    
    init(coordinator: RegistrationCoordinator,
         delegate: RegistrationDelegate) {
        self.coordinator = coordinator
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var formStack = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var registerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Register"
        return label
    }()
    
    private var firstNameTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter First Name *"
        return textField
    }()
    
    private var lastNameTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Last Name"
        return textField
    }()
    
    private var emailTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Email *"
        return textField
    }()
    
    private var passwordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Password *"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var submitButton = {
        let button = UIButton()
        var btnConfig = UIButton.Configuration.tinted()
        button.setTitle("Register", for: .normal)
        btnConfig.cornerStyle = .dynamic
        button.configuration = btnConfig
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpDismissButton()
        addSubviewsToFormStack()
        addConstraintsToFormStack()
        setUpSubmitButton()
    }
    
    private func setUpDismissButton() {
        let cancellAction = UIAction(handler: didTapCancell)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel,
                                                            primaryAction: cancellAction)
    }
    
    private func didTapCancell(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func addSubviewsToFormStack() {
        view.addSubview(formStack)
        
        formStack.addArrangedSubview(registerLabel)
        formStack.addArrangedSubview(firstNameTextField)
        formStack.addArrangedSubview(lastNameTextField)
        formStack.addArrangedSubview(emailTextField)
        formStack.addArrangedSubview(passwordTextField)
        formStack.addArrangedSubview(submitButton)
    }
    
    private func addConstraintsToFormStack() {
        view.addConstraints([
            formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 16),
            formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 16),
            formStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -16)
        ])
    }
    
    private func setUpSubmitButton() {
        let submitAction = UIAction(handler: didTapSubmit)
        submitButton.addAction(submitAction, for: .touchUpInside)
    }
    
    private func didTapSubmit(_ action: UIAction) {
        guard let firstName = firstNameTextField.text,
              checkTextFields(field: firstNameTextField, fieldType: "First Name") else {
            return
        }
        
        guard let email = emailTextField.text,
              checkTextFields(field: firstNameTextField, fieldType: "First Name") else {
            return
        }
        
        guard let password = passwordTextField.text,
              checkTextFields(field: passwordTextField, fieldType: "Password") else {
            return
        }
        
        let lastName = lastNameTextField.text ?? "not entered"
        
        saveCurrentUserInDefaults(firstName: firstName,
                                  lastName: lastName,
                                  email: email,
                                  password: password)
        
        delegate?.saveCurrentUser(registeredUser: User(firstName: firstName,
                                                       lastName: lastName,
                                                       email: email,
                                                       password: password))
        
        dismiss(animated: true)
        
    }
    
    private func checkTextFields(field: UITextField, fieldType: String) -> Bool {
        guard field.text != "" else {
            field.attributedPlaceholder = NSAttributedString(string: "\(fieldType) can't be empty",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return false
        }
        return true
    }
    
    private func saveCurrentUserInDefaults(firstName: String,
                                           lastName: String,
                                           email: String,
                                           password: String) {
        
        let user = ["firstName": firstName,
                    "lastName": lastName,
                    "email": email,
                    "password": password]
        
        guard var users:[[String: String]] = UserDefaults.standard.object(forKey: "users") as? [[String : String]] else {
            UserDefaults.standard.set(user, forKey: "users")
            return
        }
        
        users.append(user)
        
        UserDefaults.standard.set(users, forKey: "users")
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }
}
