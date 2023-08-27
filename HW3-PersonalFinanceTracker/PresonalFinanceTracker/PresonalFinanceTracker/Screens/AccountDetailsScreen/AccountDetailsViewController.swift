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

    init(for accountIndex: Int,
         coordinator: AccountDetailsCoordinator) {
        self.accountIndex = accountIndex
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpTableView()
    }

    private func setUpTableView() {
        configureTableView()
        view.addSubview(tableView)
        addTableViewConstraints()
    }

    private func configureTableView() {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdetifier)
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
        UserManager.shared.currentUser?.accounts[accountIndex].expenses.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expense = UserManager.shared.currentUser?.accounts[accountIndex].expenses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdetifier, for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = expense?.name
        cell.contentConfiguration = content

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
            UserManager.shared.currentUser?.accounts[self.accountIndex].expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
