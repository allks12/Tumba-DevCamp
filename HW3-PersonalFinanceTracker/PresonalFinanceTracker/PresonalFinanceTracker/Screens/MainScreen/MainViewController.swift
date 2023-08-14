//
//  ViewController.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 10.08.23.
//

import UIKit

class MainViewController: UIViewController {
    private let coordinator: AppCoordinator
    private var accounts: [Account] = [ /* Account(name: "Mine", type: "card", balance: 700),
                                       Account(name: "House", type: "credit", balance: 10000),
                                       Account(name: "Car", type: "credit", balance: 2000) */ ]
    
    private var tableView: UITableView!
    private let cellIdetifier = "account"
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentUser: User? = {
        guard let firstName = UserDefaults.standard.string(forKey: "firstName"),
              let lastName = UserDefaults.standard.string(forKey: "lastName"),
              let email = UserDefaults.standard.string(forKey: "email"),
              let password = UserDefaults.standard.string(forKey: "password") else {
            return nil
        }
        
        return User(firstName: firstName,
                    lastName: lastName,
                    email: email,
                    password: password)
    }()
    
    private var welcomeAccountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var accountButton: UIButton = {
        let button = UIButton()
        var btnConfig = UIButton.Configuration.filled()
        button.setTitle("New Account", for: .normal)
        btnConfig.cornerStyle = .dynamic
        button.configuration = btnConfig
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        setBarButtonItems()
        configureTableView()
        setWelcomeAccountStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let firstName = UserDefaults.standard.string(forKey: "firstName"),
              let lastName = UserDefaults.standard.string(forKey: "lastName"),
              let email = UserDefaults.standard.string(forKey: "email"),
              let password = UserDefaults.standard.string(forKey: "password") else {
            currentUser = nil
            return
        }
        
        currentUser = User(firstName: firstName,
                           lastName: lastName,
                           email: email,
                           password: password)
        tableView.reloadData()
        setWelcomeAccountStack()
        setBarButtonItems()
        setNewAccountButton()
    }
    
    private func setBarButtonItems() {
        setRightBarButtonItem()
        setLeftBarButtonItem()
    }
    
    private func setLeftBarButtonItem() {
        if currentUser == nil {
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
        if currentUser == nil {
            let registrationAction = UIAction(handler: didTapRegister)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                                primaryAction: registrationAction)
            return
        }
        navigationItem.rightBarButtonItem = nil
    }
    
    private func setUpWelcomeLabel() {
        guard currentUser != nil,
        let firstName = currentUser?.firstName else{
            welcomeLabel.text = "Welcome new user! Please log in or register!"
            return
        }
        
        welcomeLabel.text = "Welcome \(firstName)!"
    }
    
    private func setNewAccountButton() {
        let newAccountAction = UIAction(handler: didTapNewAccountButton)
        accountButton.addAction(newAccountAction, for: .touchUpInside)
    }
    
    private func setWelcomeAccountStack() {
        view.addSubview(welcomeAccountStack)
        setUpWelcomeLabel()
        welcomeAccountStack.addArrangedSubview(welcomeLabel)
        
        if currentUser != nil {
            welcomeAccountStack.addArrangedSubview(accountButton)
        }
        
        welcomeAccountStack.addArrangedSubview(tableView)
        addWelcomeAccountStackConstraints()
    }
    
    private func addWelcomeAccountStackConstraints() {
        view.addConstraints([
            welcomeAccountStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                     constant: 16),
            welcomeAccountStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                         constant: 16),
            welcomeAccountStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,                                                   constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    private func configureTableView() {
        var tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdetifier)
        tableView.dataSource = self
        
        self.tableView = tableView
    }
    
    private func didTapLogin(_ action: UIAction) {
        let loginCoordinator = LoginCoordinator(parentCoordinator: coordinator,
                                                navigationController: coordinator.navigationController,
                                                loginDelegate: self)
        coordinator.addChild(child: loginCoordinator)
        loginCoordinator.start()
    }
    
    private func didTapLogout(_ action: UIAction) {
        currentUser = nil
        accounts = []
        tableView.reloadData()
        UserDefaults.standard.set(nil, forKey: "firstName")
        UserDefaults.standard.set(nil, forKey: "lastName")
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "password")
        setBarButtonItems()
        setUpWelcomeLabel()
        accountButton.removeFromSuperview()
    }
    
    private func didTapRegister(_ action: UIAction) {
        let registrationCoordinator = RegistrationCoordinator(parentCoordinator: coordinator,
                                                              navigationController: coordinator.navigationController,
                                                              registrationDelegate: self)
        coordinator.addChild(child: registrationCoordinator)
        registrationCoordinator.start()
    }
    
    private func didTapNewAccountButton(_ action: UIAction) {
        let accountCoordinator = AccountCoordinator(parentCoordinator: coordinator,
                                                    navigationController: coordinator.navigationController,
                                                    delegate: self)
        coordinator.addChild(child: accountCoordinator)
        accountCoordinator.start()
    }
}

extension MainViewController: LoginDelegate {
    func logUserIn(_ user: User) {
        currentUser = user
        UserDefaults.standard.set(user.firstName, forKey: "firstName")
        UserDefaults.standard.set(user.lastName, forKey: "lastName")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(user.password, forKey: "password")
    }
}

extension MainViewController: RegistrationDelegate {
    func saveCurrentUser(registeredUser: User) {
        currentUser = registeredUser
    }
}

extension MainViewController: AccountDelegate {
    func saveNewAccount(_ account: Account) {
        accounts.append(account)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var account = accounts[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdetifier, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = account.name
        cell.contentConfiguration = content
        
        return cell
    }
}

