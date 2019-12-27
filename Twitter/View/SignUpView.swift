//
//  SignUpView.swift
//  Twitter
//
//  Created by Mark on 19/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

protocol SignUpDelegate {
    func createAccount(userName: String, firstName: String, lastName: String, emailAddress: String, password: String, passwordVerification: String) -> Void
}

class SignUpView: UIView {
    
    var didTapCreateAccountDelegate: SignUpDelegate?
    
    let userName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let firstName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let lastName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let emailAddress: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let passwordField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let passwordVerificationField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password Verification"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = UIColor(named: "TwitterBlue")
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createNewAccount), for: .touchUpInside)
        return button
    }()
    
    let signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    let twitterLogo: UIImageView = {
        let image = UIImage(named: "twitter")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        addSubview(signUpStackView)
        addSubview(twitterLogo)
        
        self.subViews = [userName, firstName, lastName, emailAddress, passwordField, passwordVerificationField, createAccountButton]
        subViews.forEach { view in
            addSubview(view)
            signUpStackView.addArrangedSubview(view)
        }
        
        setupConstraints()
    }
    
    //MARK: Constraint Setup
    
    fileprivate func setupConstraints() {
        
        NSLayoutConstraint.activate([
            signUpStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signUpStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            signUpStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            twitterLogo.bottomAnchor.constraint(equalTo: signUpStackView.topAnchor, constant: -20),
            twitterLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            twitterLogo.heightAnchor.constraint(equalToConstant: 100),
            twitterLogo.widthAnchor.constraint(equalToConstant: 122.78),
            
            createAccountButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc fileprivate func createNewAccount() {
        
        createAccount(userName: userName.text!, firstName: firstName.text!, lastName: lastName.text!, emailAddress: emailAddress.text!, password: passwordField.text!, passwordVerification: passwordVerificationField.text!)
        
    }
    
}

//MARK: Delegate Method

extension SignUpView: SignUpDelegate {
    func createAccount(userName: String, firstName: String, lastName: String, emailAddress: String, password: String, passwordVerification: String) {
        didTapCreateAccountDelegate?.createAccount(userName: userName, firstName: firstName, lastName: lastName, emailAddress: emailAddress, password: password, passwordVerification: passwordVerification)
    }
    
}
