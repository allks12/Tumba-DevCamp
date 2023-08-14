//
//  AccountViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import UIKit

protocol AccountDelegate: AnyObject {
    func saveNewAccount(_ account: Account)
}

class AccountViewController: UIViewController {
    private let coordinator: AccountCoordinator
    weak var delegate: AccountDelegate?
    
    init(coordinator: AccountCoordinator, delegate: AccountDelegate) {
        self.coordinator = coordinator
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var formStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var createAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemPurple
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "Create New Account"
        return label
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Name of Account"
        return textField
    }()
    
    private var typeTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Type of Account"
        return textField
    }()
    
    private var balanceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Balance of Account"
        return textField
    }()
    
    private var submitButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.tinted()
        button.setTitle("Create Account", for: .normal)
        config.cornerStyle = .dynamic
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpDismissButton()
        setUpFormStack()
    }
    
    private func setUpDismissButton() {
        let cancellAction = UIAction(handler: didTapCancel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .cancel,
                                                            primaryAction: cancellAction)
    }
    
    private func setCreateAccountButton() {
        let createAction = UIAction(handler: didTapCreateAccount)
        submitButton.addAction(createAction, for: .touchUpInside)
    }
    
    private func setUpFormStack() {
        view.addSubview(formStack)
        
        formStack.addArrangedSubview(createAccountLabel)
        formStack.addArrangedSubview(nameTextField)
        formStack.addArrangedSubview(typeTextField)
        formStack.addArrangedSubview(balanceTextField)
        formStack.addArrangedSubview(submitButton)
        
        setCreateAccountButton()
        addFormStackConstraints()
    }
    
    private func addFormStackConstraints() {
        view.addConstraints([
            formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: 16),
            formStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -16),
            formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 16)
        ])
    }
    
    private func didTapCancel(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func didTapCreateAccount(_ action: UIAction) {
        guard let name = nameTextField.text,
              name != "" else {
            nameTextField.attributedPlaceholder = NSAttributedString(string: "Name can't be empty",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        
        guard let type = typeTextField.text,
              type != "" else {
            typeTextField.attributedPlaceholder = NSAttributedString(string: "Type can't be empty",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        
        guard let balance = balanceTextField.text,
              balance != "" else {
            balanceTextField.attributedPlaceholder = NSAttributedString(string: "Balance can't be empty",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            return
        }
        
        delegate?.saveNewAccount(Account(name: name,
                                         type: type,
                                         balance: Int(balance) ?? 0))
        
        dismiss(animated: true)
    }
    
}
