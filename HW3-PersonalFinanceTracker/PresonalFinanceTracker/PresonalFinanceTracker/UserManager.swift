//
//  UserManager.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 27.08.23.
//

import UIKit

class UserManager {
    static let shared = UserManager()
    private let fileName = "data.json"
    var users: [User] = [] {
        didSet {
            saveUsers()
        }
    }

    init() {
        guard let usersData = try? Data(contentsOf: FileManager.getURL(for: fileName)),
              let users = try? JSONDecoder().decode([User].self, from: usersData) else {
            return
        }
        self.users = users
    }
    
    private func saveUsers() {
        try? JSONEncoder().encode(users).write(to: FileManager.getURL(for: fileName))
    }
}

extension FileManager {
    static func getURL(for filename: String,
                       in folder: FileManager.SearchPathDirectory = .documentDirectory) -> URL {
        FileManager.default.urls(for: folder, in: .userDomainMask)[0].appending(path: filename)
    }
}
