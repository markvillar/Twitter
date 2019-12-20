//
//  SignUpController.swift
//  Twitter
//
//  Created by Mark on 19/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    var viewHandle: SignUpView?
    
    let auth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (view as? SignUpView)?.didTapCreateAccountDelegate = self
    }
    
    override func loadView() {
        super.loadView()
        view = SignUpView()
    }
    
}

extension SignUpController: SignUpDelegate {
    
    func createAccount(userName: String, emailAddress: String, password: String) {
        
        Auth.auth().createUser(withEmail: emailAddress, password: password) { [unowned self] result, err in
            
            if let error = err {
                print(error)
            } else {
                print("Successfully Registered")
                
                let homeController = HomeController()
                self.present(homeController, animated: true)
            }
            
        }
        
    }
    
}
