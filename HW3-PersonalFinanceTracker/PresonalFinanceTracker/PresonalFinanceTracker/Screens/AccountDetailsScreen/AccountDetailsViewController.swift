//
//  AccountDetailsViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    let coordinator: AccountDetailsCoordinator
    let cellIdetifier = "expense"
    let accountIndex: Int
    var tableView: UITableView!

    private var categories: [ExpenseType] = ExpenseType.allCases

    init(for accountIndex: Int,
         coordinator: AccountDetailsCoordinator) {
        self.accountIndex = accountIndex
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpBarButtons()
        setUpSearchBar()
        setUpTableView()
    }

    private func setUpBarButtons() {
        let addExpenseAction = UIAction(title: "Add Expense", handler: didTapAddExpense)
        navigationItem.rightBarButtonItem = UIBarButtonItem(primaryAction: addExpenseAction)
    }

    private func didTapAddExpense(_ action: UIAction) {
        coordinator.navigateToExpenseAddition(for: accountIndex)
    }

    private func setUpTableView() {
        configureTableView()
        view.addSubview(tableView)
        addTableViewConstraints()
    }

    private func setUpSearchBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self
    }

    private func configureTableView() {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)

        tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: cellIdetifier)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
    }

    private func addTableViewConstraints() {
        view.addConstraints([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,                                 constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: 20)
        ])
    }
}

extension AccountDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserManager.shared.currentUser?.accounts[accountIndex].expenses.filter { expense in
            categories.contains(expense.type)
        }.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = UserManager.shared.currentUser?.accounts[accountIndex].expenses.filter { expense in
            categories.contains(expense.type)
        }[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdetifier, for: indexPath) as! ExpenseTableViewCell

        cell.name.text = expense?.name
        cell.amount.text = "\(expense?.amount ?? 0)"
        cell.type.text = expense?.type.rawValue
        cell.date.text = expense?.date.formatted(date: .numeric, time: .standard)

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Expenses"
    }
}

extension AccountDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let expenseToRemove = UserManager.shared.currentUser?.accounts[self.accountIndex].expenses.filter { expense in
                self.categories.contains(expense.type)
            }[indexPath.row]
            guard let expenseIndex = UserManager.shared.currentUser?.accounts[self.accountIndex].expenses.firstIndex(where: {
                $0 == expenseToRemove
            }) else {
                return
            }
            UserManager.shared.currentUser?.accounts[self.accountIndex].expenses.remove(at: expenseIndex)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension AccountDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            categories = ExpenseType.allCases
        } else {
            categories = ExpenseType.allCases.filter {
                $0.rawValue.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
