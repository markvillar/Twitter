//
//  ComposeTweetController.swift
//  Twitter
//
//  Created by Mark on 18/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase

class ComposeTweetController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    override func loadView() {
        super.loadView()
        view = ComposeTweetView()
    }
    
    fileprivate func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tweet", style: .done, target: self, action: #selector(composeTweet))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissComposeTweet))
    }
    
    @objc func composeTweet() {
        
        guard let composeView = view as? ComposeTweetView else { dismissComposeTweet(); return }
        
        guard let tweet = composeView.tweetText.text else { return }
        
        let composedTweet = Tweet(content: tweet, createdAt: Timestamp(date: Date()), user: User(firstName: "Mark", lastName: "Villar",  userName: "@mark"))
        
        let firestore = NetworkCall()
        firestore.add(data: composedTweet, in: Subcollections.tweets)
        
        dismissComposeTweet()
    }
    
    @objc func dismissComposeTweet() {
        dismiss(animated: true, completion: nil)
    }

}
