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
}

enum AccountType: String, CaseIterable, Codable {
    case debit = "Debit"
    case credit = "Credit"
    case wallet = "Wallet"
}
