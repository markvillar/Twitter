//
//  TabBarController.swift
//  Twitter
//
//  Created by Mark on 18/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
        setUpTabBar()
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
