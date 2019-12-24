//
//  SignInView.swift
//  Twitter
//
//  Created by Mark on 19/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

protocol SignInDelegate {
    func signIn(emailAddress: String, password: String) -> Void
    func register() -> Void
}

class SignInView: UIView {
    
    var didTapSignIn: SignInDelegate?
    
    var subViews: [UIView]!
    
    let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        return textField
    }()
    
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Signin", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(registerSegue), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: Initialiser
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup View
    fileprivate func setupView() {
        backgroundColor = .systemBackground
        
        addSubview(stackView)
        
        self.subViews = [emailField, passwordField, signInButton, registerButton]
        
        subViews.forEach { view in
            addSubview(view)
            stackView.addArrangedSubview(view)
        }
        
        setupConstraints()
    }
    
    //MARK: Constraints
    fileprivate func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc fileprivate func registerSegue() {
        register()
    }
    
    @objc fileprivate func login() {
        signIn(emailAddress: emailField.text!, password: passwordField.text!)
    }
    
}


extension SignInView: SignInDelegate {
    
    func register() {
        //Segue to register page
        didTapSignIn?.register()
    }
    
    func signIn(emailAddress: String, password: String) {
        didTapSignIn?.signIn(emailAddress: emailAddress, password: password)
    }
    
}