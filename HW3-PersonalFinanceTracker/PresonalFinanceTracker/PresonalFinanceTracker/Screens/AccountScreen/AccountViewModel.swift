//
//  AccountViewModel.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 21.08.23.
//

import Foundation

class AccountViewModel {
    enum AccountError: Error {
        case invalidName
        case balanceIsNotANumber
        case balanceIsLowerThanOne
        
        var errorMessage: String {
            switch self {
            case .invalidName:
                return "Name must be at least 2 letters!"
            case .balanceIsNotANumber:
                return "Balance must be a number!"
            case .balanceIsLowerThanOne:
                return "Balance must be higher than 0!"
            }
        }
    }
    
    func createAccount(nameField: RoundedValidatedTextField,
                       accountType: AccountType,
                       balanceField: RoundedValidatedTextField) -> Account? {
        var success = true
        var account = Account(name: "", type: accountType, balance: 0)
        
        let name = checkIfNameInputIsValid(nameField)
        if name == nil {
            success = false
        } else {
            account.name = name!
        }
        
        let balance = checlIfBalanceInputIsValid(balanceField)
        if balance == nil {
            success = false
        } else {
            account.balance = balance!
        }
        
        if success {
            return account
        }
        return nil
    }
    
    private func checkIfNameInputIsValid(_ nameField: RoundedValidatedTextField) -> String? {
        guard let nameInput = nameField.text else {
            return nil
        }
        
        switch validateName(name: nameInput) {
        case .success(let name):
            nameField.removeError()
            return name
        case .failure(let error):
            nameField.addErrorMsg(error: error.errorMessage)
            return nil
        }
    }
    
    private func validateName(name: String) -> Result<String, AccountError> {
        if name.count > 1 {
            return .success(name)
        }
        return .failure(.invalidName)
    }
    
    private func checlIfBalanceInputIsValid(_ balanceField: RoundedValidatedTextField) -> Double? {
        guard let balanceInput = balanceField.text else {
            return nil
        }
        
        switch validateBalance(balance: balanceInput) {
        case .success(let balance):
            balanceField.removeError()
            return balance
        case .failure(let error):
            balanceField.addErrorMsg(error: error.errorMessage)
            return nil
        }
    }
    
    private func validateBalance(balance: String) -> Result<Double, AccountError> {
        guard let balance = Double(balance) else {
            return .failure(.balanceIsNotANumber)
        }
        if balance < 1 {
            return . failure(.balanceIsLowerThanOne)
        }
        return .success(balance)
    }
}
