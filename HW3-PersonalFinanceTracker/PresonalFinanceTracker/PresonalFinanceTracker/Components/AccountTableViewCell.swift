//
//  AccountTableViewCell.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    private let accountsStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    let balance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let type: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 15)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpAccountsStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addAccountsStackSubviews() {
        accountsStackView.addArrangedSubview(name)
        accountsStackView.addArrangedSubview(balance)
        accountsStackView.addArrangedSubview(type)
        contentView.addSubview(accountsStackView)
    }

    func addAccountsStackConstraints() {
        contentView.addConstraints([
            accountsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            accountsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            accountsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            accountsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func setUpAccountsStackView() {
        addAccountsStackSubviews()
        addAccountsStackConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        balance.text = nil
        type.text = nil
    }
}
