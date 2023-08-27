//
//  ViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 10.08.23.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    private let coordinator: AppCoordinator
    
    private var tableView: UITableView!
    private let cellIdetifier = "account"
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setBarButtonItems()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        setBarButtonItems()
    }
    
    private func setBarButtonItems() {
        setRightBarButtonItem()
        setLeftBarButtonItem()
    }
    
    private func setLeftBarButtonItem() {
        if UserManager.shared.currentUser == nil {
            let loginAction = UIAction(handler: didTapLogin)
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Login",
                                                               primaryAction: loginAction)
            return
        }
        
        let logoutAction = UIAction(handler: didTapLogout)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                           primaryAction: logoutAction)
    }
    
    private func setRightBarButtonItem() {
        if UserManager.shared.currentUser == nil {
            let registrationAction = UIAction(handler: didTapRegister)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                                primaryAction: registrationAction)
            return
        }
        let createAccountAction = UIAction(handler: didTapNewAccountButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Account",
                                                            primaryAction: createAccountAction)
    }
    
    private func setUpTableView() {
        configureTableView()
        view.addSubview(tableView)
        addTableViewConstraints()
    }
    
    private func setUpWelcomeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        
        guard let firstName = UserManager.shared.currentUser?.firstName else {
                label.text = "Welcome!"
                return label
        }
        
        label.text = "Hello, \(firstName)!"
        return label
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
    
    private func configureTableView() {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdetifier)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
    }
    
    private func didTapLogin(_ action: UIAction) {
        let loginCoordinator = LoginCoordinator(parentCoordinator: coordinator,
                                                navigationController: coordinator.navigationController)
        coordinator.addChild(child: loginCoordinator)
        loginCoordinator.start()
    }
    
    private func didTapLogout(_ action: UIAction) {
        UserManager.shared.currentUser = nil
        tableView.reloadData()
        setBarButtonItems()
    }
    
    private func didTapRegister(_ action: UIAction) {
        let registrationCoordinator = RegistrationCoordinator(parentCoordinator: coordinator,
                                                              navigationController: coordinator.navigationController)
        coordinator.addChild(child: registrationCoordinator)
        registrationCoordinator.start()
    }
    
    private func didTapNewAccountButton(_ action: UIAction) {
        let accountCoordinator = AccountCoordinator(parentCoordinator: coordinator,
                                                    navigationController: coordinator.navigationController)
        coordinator.addChild(child: accountCoordinator)
        accountCoordinator.start()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        UserManager.shared.currentUser?.accounts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = UserManager.shared.currentUser?.accounts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdetifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = account?.name
        cell.contentConfiguration = content
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        return setUpWelcomeLabel()
    }
}

