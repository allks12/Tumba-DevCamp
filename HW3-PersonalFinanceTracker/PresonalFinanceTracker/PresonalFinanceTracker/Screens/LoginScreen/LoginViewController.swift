//
//  LoginViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 10.08.23.
//

import UIKit

class LoginViewController: UIViewController {

    private let coordinator: LoginCoordinator
    private let viewModel = UserAuthenticationViewModel()
    
    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
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
        stackView.distribution = .fill
        stackView.alignment = .fill
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
    
    private var emailTextField: RoundedValidatedTextField = {
        let textField = RoundedValidatedTextField()
        textField.title = "Email*"
        textField.autocorrectionType = .no
        return textField
    }()
    
    private var passwordTextField: RoundedValidatedTextField = {
        let textField = RoundedValidatedTextField()
        textField.title = "Password*"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var unexistingUserLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemRed
        return label
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
        stackView.addArrangedSubview(unexistingUserLabel)
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
        
        guard let currentUser = viewModel.login(emailField: emailTextField,
                                                passwordField: passwordTextField,
                                                unexistingUserLabel: unexistingUserLabel) else {
            return
        }
        UserManager.shared.currentUser = currentUser
        dismiss(animated: true)
    }

}
