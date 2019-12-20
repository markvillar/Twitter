//
//  SignInController.swift
//  Twitter
//
//  Created by Mark on 19/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase

class SignInController: UIViewController {

    override func loadView() {
        super.loadView()
        view = SignInView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (view as? SignInView)?.didTapSignIn = self
    }
    
}

extension SignInController: SignInDelegate {
    
    func signIn(emailAddress: String, password: String) {
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { authDataResult, error in
            
        }
        
    }
    
}
