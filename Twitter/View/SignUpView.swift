//
//  SignUpView.swift
//  Twitter
//
//  Created by Mark on 19/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

protocol SignUpDelegate {
    func createAccount(userName: String, emailAddress: String, password: String) -> Void
}

class SignUpView: UIView {
    
    var didTapCreateAccountDelegate: SignUpDelegate?
    
    let userName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    let firstName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    let lastName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    let emailAddress: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    let passwordField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    let passwordVerificationField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password Verification"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }()
    
    let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    var subViews: [UIView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup Views
    
    fileprivate func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(stackView)
        
        self.subViews = [userName, firstName, lastName, emailAddress, passwordField, passwordVerificationField, createAccountButton]
        subViews.forEach { view in
            addSubview(view)
            stackView.addArrangedSubview(view)
        }
        
        setupConstraints()
    }
    
    //MARK: Constraint Setup
    
    fileprivate func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc fileprivate func createNewAccount() {
        
        createAccount(userName: userName.text!, emailAddress: emailAddress.text!, password: passwordField.text!)
        
    }
    
}

//MARK: Delegate Method

extension SignUpView: SignUpDelegate {
    
    func createAccount(userName: String, emailAddress: String, password: String) {
        didTapCreateAccountDelegate?.createAccount(userName: userName, emailAddress: emailAddress, password: password)
    }
    
}
