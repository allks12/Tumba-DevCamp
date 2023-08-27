//
//  RoundedValidatedTextField.swift
//  PresonalFinanceTracker
//
//  Created by Aleksandra on 14.08.23.
//

import Foundation
import UIKit
import CoreGraphics

class RoundedValidatedTextField: UIStackView {
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        textField.addConstraint(textField.heightAnchor.constraint(equalToConstant: 40))
        return textField
    }()
    
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemRed
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    var isSecureTextEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    var autocorrectionType: UITextAutocorrectionType {
        get {
            textField.autocorrectionType
        }
        set {
            textField.autocorrectionType = newValue
        }
    }
    
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    var title: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 2
        addSubviews()
    }
    
    private func addSubviews() {
        addArrangedSubview(label)
        addArrangedSubview(textField)
        addArrangedSubview(errorLabel)
    }
    
    func addErrorMsg(error: String) {
        errorLabel.text = error
        textField.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    func removeError() {
        errorLabel.text = " "
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        removeArrangedSubview(errorLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
