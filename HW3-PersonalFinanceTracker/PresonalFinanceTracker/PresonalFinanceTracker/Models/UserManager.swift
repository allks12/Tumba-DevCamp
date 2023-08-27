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
    private let currentUserKey = "currentUserEmail"
    var users: [User] = [] {
        didSet {
            saveUsers()
        }
    }
    var currentUser: User? {
        get {
            guard let userData = UserDefaults.standard.data(forKey: currentUserKey),
                  let userEmail = try? JSONDecoder().decode(String.self, from: userData) else {
                return nil
            }
            return users.first {
                $0.email == userEmail
            }
        }
        set {
            if let desiredEmail = try? JSONEncoder().encode(newValue?.email) { UserDefaults.standard.set(desiredEmail, forKey: currentUserKey)
            }
            guard let newValue else {
                return
            }

            if let userIndex = users.firstIndex(where: {
                $0.email == newValue.email
            }) {
                users[userIndex] = newValue
            } else {
                users.append(newValue)
            }
        }
    }

    init() {
        print(FileManager.getURL(for: fileName))
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
