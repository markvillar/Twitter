//
//  TabBarController.swift
//  Twitter
//
//  Created by Mark on 18/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    let auth = Auth.auth()
    
    var homeScreenController: UINavigationController = {
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeController(collectionViewLayout: layout)
        var hc = UINavigationController(rootViewController: homeController)
        
        hc.tabBarItem.title = "Home"
        //hc.tabBarItem.image = UIImage(named: "list")
        return hc
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: Auth Listener
        auth.addStateDidChangeListener { [unowned self] auth, user in
            
            print("Auth Listener")
            
            guard let authenticatedUser = user else {
                let signIn = SignInController()
                let navigationSignin = UINavigationController(rootViewController: signIn)
                navigationSignin.isModalInPresentation = true
                self.present(navigationSignin, animated: true)
                return
            }
            
            print("\(String(describing: authenticatedUser.email))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
        setUpTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        auth.removeStateDidChangeListener(auth)
    }
    
    fileprivate func setUpTabBar() {
        tabBar.isTranslucent = true
        tabBar.isOpaque = true
    }
    
    //MARK: RootViewControllers
    fileprivate func setUpViewControllers() {
        
        tabBar.isTranslucent = false
        
        let viewControllerList = [homeScreenController]
        
        setViewControllers(viewControllerList, animated: true)
    }
    
}
