//
//  RegistrationViewModel.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 16.08.23.
//

import UIKit

class UserAuthenticationViewModel {
    
    enum UserAuthenticationError: Error {
        case invalidEmail
        case shortName
        case weakPassword
        case unmatchingPasswords
        case unexistingUser
        
        var errorMessage: String {
            switch self {
            case .invalidEmail:
                return "Invalid email!"
            case .shortName:
                return "Name must be at least 2 characters!"
            case .weakPassword:
                return """
                        Password is weak! Must contain:
                        - special symbol  - capital letter  - lower case letter
                        - number  - at least 8 symbols
                       """
            case .unmatchingPasswords:
                return "Passwords don't match"
            case .unexistingUser:
                return "User with this email and/or password doesn't exist!"
            }
        }
    }
    
    func register(firstNameField: RoundedValidatedTextField,
                  lastNameField: RoundedValidatedTextField,
                  emailField: RoundedValidatedTextField,
                  passwordField: RoundedValidatedTextField,
                  confirmPasswordField: RoundedValidatedTextField) -> User? {
        var success = true
        var user = User(firstName: "", lastName: "", email: "", password: "")
        
        let firstName = checkIfNameInputIsValid(nameField: firstNameField)
        if firstName == nil {
            success = false
        } else {
            user.firstName = firstName!
        }
        
        let lastName = lastNameField.text ?? "not-entered"
        user.lastName = lastName
        
        let email = checkIfEmailInputIsValid(emailField: emailField)
        if email == nil {
            success = false
        } else {
            user.email = email!
        }
        
        let password = checkIfPasswordInputIsValid(passwordField: passwordField)
        if password == nil {
            success = false
        } else {
            user.password = password!
        }
        
        if !checkIfPasswordsMatch(comparePasswordField: confirmPasswordField,
                                 password: password) {
            success = false
        }
        
        if success {
            return user
        }
        return nil
    }
    
    func login (emailField: RoundedValidatedTextField,
                passwordField: RoundedValidatedTextField,
                unexistingUserLabel: UILabel) -> User? {
        guard let user = validateLoginInput(emailField, passwordField) else {
            return nil
        }
        
        guard let existingUser = checkIfDesiredUserInExists(desiredUser: user) else {
            unexistingUserLabel.text = UserAuthenticationError.unexistingUser.errorMessage
            emailField.addErrorMsg(error: " ")
            passwordField.addErrorMsg(error: " ")
            return nil
        }
        
        return existingUser
    }
    
    private func validateLoginInput(_ emailField: RoundedValidatedTextField,
               _ passwordField: RoundedValidatedTextField) -> User? {
        var success = true
        var loggedUser = User(firstName: "", lastName: "", email: "", password: "")
        
        let email = checkIfEmailInputIsValid(emailField: emailField)
        if email == nil {
            success = false
        } else {
            loggedUser.email = email!
        }
        
        let password = checkIfPasswordInputIsValid(passwordField: passwordField)
        if password == nil {
            success = false
        } else {
            loggedUser.password = password!
        }
        
        if success {
            return loggedUser
        } else {
            return nil
        }
    }
    
    private func checkIfDesiredUserInExists(desiredUser: User) -> User? {
        guard let users:[[String : String]] = UserDefaults.standard.object(forKey: "users") as? [[String : String]] else {
            return nil
        }
        
        let loggedUser = users.first { user in
            user["email"] == desiredUser.email && user["password"] == desiredUser.password
        }
        
        guard let user = loggedUser else {
            return nil
        }
        
        return User(firstName: user["firstName"]!,
                    lastName: user["lastName"] ?? "not-entered",
                    email: user["email"]!,
                    password: user["password"]!)
    }
    
    private func checkIfNameInputIsValid(nameField: RoundedValidatedTextField) -> String?{
        guard let nameInput = nameField.text else {
            return nil
        }
        
        switch (validateName(name: nameInput)) {
        case .success(let name):
            nameField.removeError()
            return name
        case .failure(let error):
            nameField.addErrorMsg(error: error.errorMessage)
            return nil
        }
    }
    
    private func validateName(name: String) -> Result<String, UserAuthenticationError> {
        if name.count > 1 {
            return .success(name)
        }
        return .failure(.shortName)
    }
    
    private func checkIfEmailInputIsValid(emailField: RoundedValidatedTextField) -> String? {
        guard let emailInput = emailField.text else {
            return nil
        }
        
        switch (validateEmail(email: emailInput)) {
        case .success(let email):
            emailField.removeError()
            return email
        case .failure(let error):
            emailField.addErrorMsg(error: error.errorMessage)
            return nil
        }
    }
    
    private func validateEmail(email: String) -> Result<String, UserAuthenticationError> {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            return .success(email)
        }
        
        return .failure(.invalidEmail)
    }
    
    private func checkIfPasswordInputIsValid(passwordField: RoundedValidatedTextField) -> String? {
        guard let passwordInput = passwordField.text else {
            return nil
        }
        
        switch (validatePassword(password: passwordInput)) {
        case .success(let password):
            passwordField.removeError()
            return password
        case .failure(let error):
            passwordField.addErrorMsg(error: error.errorMessage)
            return nil
        }
    }
    
    private func validatePassword(password: String) -> Result<String, UserAuthenticationError> {
        let passwordRegex = "(?=.*[a-z].*)(?=.*[A-Z])(?=.*[-@$!%*#?&].*).{8,}"
        
        if NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password) {
            return .success(password)
        }
        return .failure(.weakPassword)
    }
    
    private func checkIfPasswordsMatch(comparePasswordField: RoundedValidatedTextField,
                                       password: String?) -> Bool {
        guard let comparePasswordInput = comparePasswordField.text else {
            return false
        }
        
        switch (validatePasswordsComparrison(password: password,
                                             comparePassword: comparePasswordInput)) {
        case .success(_):
            comparePasswordField.removeError()
            return true
        case .failure(let error):
            comparePasswordField.addErrorMsg(error: error.errorMessage)
            return false
        }
    }
    
    private func validatePasswordsComparrison(password: String?,
                                              comparePassword: String)
    -> Result<Bool, UserAuthenticationError> {
        if comparePassword == password {
            return .success(true)
        }
        return .failure(.unmatchingPasswords)
    }
}
