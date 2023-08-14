//
//  LoginViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 10.08.23.
//

import UIKit

protocol LoginDelegate: AnyObject {
    func logUserIn(_ user: User)
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginDelegate?
    private let coordinator: LoginCoordinator
    
    init(coordinator: LoginCoordinator, delegate: LoginDelegate?) {
        self.coordinator = coordinator
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var loginLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Login"
        return label
    }()
    
    private var emailTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Email"
        return textField
    }()
    
    private var passwordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var submitButton = {
        let button = UIButton()
        var btnConfig = UIButton.Configuration.tinted()
        button.setTitle("Login", for: .normal)
        btnConfig.cornerStyle = .dynamic
        button.configuration = btnConfig
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupDismissButton()
        addSubviews()
        addStackViewConstraints()
        setupSubmitButton()
    }
    
    private func setupDismissButton() {
        let cancelAction = UIAction(handler: didTapCancelButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel,
                                                            primaryAction: cancelAction)
    }
    
    private func setupSubmitButton() {
        let submitAction = UIAction(handler: didTapSubmit)
        submitButton.addAction(submitAction, for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(submitButton)
    }
    
    private func addStackViewConstraints() {
        view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 16)
        ])
    }
    
    private func didTapCancelButton(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func didTapSubmit(_ action: UIAction) {
        guard var users:[[String : String]] = UserDefaults.standard.object(forKey: "users") as? [[String : String]] else {
            return
        }
        
        let logedUser = users.first { user in
            user["email"] == emailTextField.text && user["password"] == passwordTextField.text
        }
        
        
        guard let user = logedUser else {
            print("here")
            return
        }
        
        guard let firstName = user["firstName"],
              let lastName = user["lastName"],
              let email = user["email"],
              let password = user["password"] else {
            print("see here")
            return
        }
        
        delegate?.logUserIn(User(firstName: firstName,
                                 lastName: lastName,
                                 email: email,
                                 password: password))
        dismiss(animated: true)
    }

}
