//
//  CreeateExpenseViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class CreeateExpenseViewController: UIViewController {
    let coordinator: CreateExpenseCoordinator
    let accountIndex: Int
    private var selectedType: ExpenseType = .groceries

    init(for index: Int, coordinator: CreateExpenseCoordinator) {
        self.coordinator = coordinator
        self.accountIndex = index
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
        textField.title = "Name of Expense"
        return textField
    }()


    private var typePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private var balanceTextField: RoundedValidatedTextField = {
        let textField = RoundedValidatedTextField()
        textField.title = "Expense amount"
        textField.keyboardType = .decimalPad
        return textField
    }()

    private var submitButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.tinted()
        button.setTitle("Create Expense", for: .normal)
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
        let createAction = UIAction(handler: didTapCreateExpense)
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
        coordinator.cancel()
    }

    private func didTapCreateExpense(_ action: UIAction) {
        let newExpense = Expense(name: nameTextField.text ?? "",
                                 type: selectedType,
                                 amount: Double(balanceTextField.text ?? "") ?? 0)

        UserManager.shared.currentUser?.accounts[accountIndex].expenses.append(newExpense)
        coordinator.submit()
    }
}

extension CreeateExpenseViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ExpenseType.allCases.count
    }
}

extension CreeateExpenseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
           return ExpenseType.allCases[row].rawValue
       }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        selectedType = ExpenseType.allCases[row]
    }
}
