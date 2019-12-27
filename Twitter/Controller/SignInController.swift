//
//  SignInController.swift
//  Twitter
//
//  Created by Mark on 19/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class SignInController: UIViewController {
    
    let auth = Auth.auth()
    
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
    
    func register() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    func signIn(emailAddress: String, password: String) {
        
        auth.signIn(withEmail: emailAddress, password: password) { [weak self] authDataResult, error in
            
            self?.auth.signIn(withEmail: emailAddress, password: password, completion: { authDataResult, authError in
                
                if let authError = error {
                    
                    AlertController.customAlert(title: "Error", message: authError.localizedDescription, on: self)
                    
                } else {
                    print("authDataResult: \(String(describing: authDataResult?.user))")
                    
                    //Dismiss the Signin view after successful signin.
                    self?.navigationController?.dismiss(animated: true, completion: nil)
                }
                
            })
            
        }
        
    }
    
}
