//
//  Account.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

struct Account: Codable {
    var name: String
    var type: AccountType
    var balance: Double
    var expenses: [Expense] = []

    var currentBalance: Double {
        var amount = balance
        expenses.forEach { expense in
            amount -= expense.amount
        }
        return amount
    }
}

struct Expense: Codable, Equatable {
    var name: String
    var type: ExpenseType
    var amount: Double
    var date: Date = .now
}

enum ExpenseType: String, CaseIterable, Codable {
    case groceries = "Groceries"
    case health = "Health"
    case education = "Education"
    case leisure = "Leisure"
}

enum AccountType: String, CaseIterable, Codable {
    case debit = "Debit"
    case credit = "Credit"
    case wallet = "Wallet"
}
