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
    
    func createAccount(userName: String, firstName: String, lastName: String, emailAddress: String, password: String) {
        
        auth.createUser(withEmail: emailAddress, password: password) { [weak self] result, err in
            
            if let error = err {
                
                AlertController.customAlert(title: "Registration Error", message: error.localizedDescription, on: self)
                
            } else {
                
                guard let authResult = result else { return }
                
                //Construct the user object
                let userDetails = User(firstName: firstName, lastName: lastName, userName: userName)
                
                //Save to the database
                let firestore = NetworkCall()
                firestore.add(with: authResult.user.uid, data: userDetails, in: Subcollections.users)
                
                print("Successfully Registered")
                
                self?.navigationController?.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
}
