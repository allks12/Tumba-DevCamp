//
//  RegistrationViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import UIKit

class RegistrationViewController: UIViewController {
    private let coordinator: RegistrationCoordinator
    private let viewModel = UserAuthenticationViewModel()
    private var textFields: [RoundedValidatedTextField] = []

    init(coordinator: RegistrationCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var formStack = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
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
    
    private var firstNameTextField: RoundedValidatedTextField = {
        let field = RoundedValidatedTextField()
        field.title = "First Name*"
        return field
    }()
    
    private var lastNameTextField: RoundedValidatedTextField = {
        let field = RoundedValidatedTextField()
        field.title = "Last Name"
        return field
    }()
    
    private var emailTextField: RoundedValidatedTextField = {
        let field = RoundedValidatedTextField()
        field.title = "Email*"
        field.autocorrectionType = .no
        return field
    }()
    
    private var passwordTextField = {
        var field = RoundedValidatedTextField()
        field.isSecureTextEntry = true
        field.autocorrectionType = .no
        field.title = "Password*"
        return field
    }()
    
    private var confirmPasswordTextField = {
        var field = RoundedValidatedTextField()
        field.isSecureTextEntry = true
        field.title = "Confirm Password*"
        field.autocorrectionType = .no
        return field
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
        formStack.addArrangedSubview(confirmPasswordTextField)
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
    
    func didTapSubmit(_ action: UIAction) {
        guard let user = viewModel.register(firstNameField: firstNameTextField,
                                            lastNameField: lastNameTextField,
                                            emailField: emailTextField,
                                            passwordField: passwordTextField,
                                            confirmPasswordField: confirmPasswordTextField) else {
            return
        }
        UserManager.shared.currentUser = user
        dismiss(animated: true)
    }
}
