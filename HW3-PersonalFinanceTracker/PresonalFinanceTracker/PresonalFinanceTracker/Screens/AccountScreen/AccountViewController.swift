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
    private let viewModel = AccountViewModel()
    private var selectedType: AccountType?
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
    
    private var nameTextField: RoundedValidatedTextField = {
        let textField = RoundedValidatedTextField()
        textField.title = "Name of Account"
        return textField
    }()
    
    private var typeTextField: RoundedValidatedTextField = {
        let textField = RoundedValidatedTextField()
        textField.title = "Type of Account"
        return textField
    }()
    
    private var typePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private var balanceTextField: RoundedValidatedTextField = {
        let textField = RoundedValidatedTextField()
        textField.title = "Balance of Account"
        textField.keyboardType = .decimalPad
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
    
    private func setUpPickerView() {
        typePickerView.dataSource = self
        typePickerView.delegate = self
    }
    
    private func setUpFormStack() {
        view.addSubview(formStack)
        setCreateAccountButton()
        setUpPickerView()
        
        formStack.addArrangedSubview(createAccountLabel)
        formStack.addArrangedSubview(typePickerView)
        formStack.addArrangedSubview(nameTextField)
        formStack.addArrangedSubview(balanceTextField)
        formStack.addArrangedSubview(submitButton)
        
        addFormStackConstraints()
    }
    
    private func addFormStackConstraints() {
        view.addConstraints([
            formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                              constant: 16),
            formStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -16),
            formStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 16),
            
            typePickerView.heightAnchor.constraint(
                            equalToConstant: typePickerView.intrinsicContentSize.height / 2.5)
        ])
    }
    
    private func didTapCancel(_ action: UIAction) {
        dismiss(animated: true)
    }
    
    private func didTapCreateAccount(_ action: UIAction) {
        guard let newAccount = viewModel.createAccount(nameField: nameTextField,
                                                       accountType: selectedType!,
                                                       balanceField: balanceTextField) else {
            return
        }
        
        delegate?.saveNewAccount(newAccount)
        dismiss(animated: true)
    }
    
}

extension AccountViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        AccountType.allCases.count
    }
}

extension AccountViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
           return AccountType.allCases[row].rawValue
       }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
            let selected = AccountType.allCases[row]
        selectedType = selected
        }
}
