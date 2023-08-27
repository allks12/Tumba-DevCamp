//
//  ExpenseTableViewCell.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    private let expenseStack: UIStackView = {
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
    let amount: UILabel = {
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
    let date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 13)
        label.textAlignment = .center
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
        expenseStack.addArrangedSubview(name)
        expenseStack.addArrangedSubview(amount)
        expenseStack.addArrangedSubview(type)
        contentView.addSubview(expenseStack)
        contentView.addSubview(date)
    }

    func addAccountsStackConstraints() {
        contentView.addConstraints([
            expenseStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            expenseStack.bottomAnchor.constraint(equalTo: date.topAnchor, constant: -6),
            expenseStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            expenseStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func setUpAccountsStackView() {
        addAccountsStackSubviews()
        addAccountsStackConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        amount.text = nil
        type.text = nil
    }
}
