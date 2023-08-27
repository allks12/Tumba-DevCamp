//
//  User.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 13.08.23.
//

import Foundation
import UIKit

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var accounts: [Account] = []
}
