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
        
        //Disable tweet button until user enters at least one character/text
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        guard let composeView = view as? ComposeTweetView else { return }
        
        composeView.tweetText.delegate = self
    }
    
    @objc func composeTweet() {
        
        guard let composeView = view as? ComposeTweetView else { dismissComposeTweet(); return }
        
        guard let tweet = composeView.tweetText.text else { return }
        
        if composeView.tweetText.text.isEmpty {
            //No text was added
            dismissComposeTweet()
        } else {
            let composedTweet = Tweet(content: tweet, createdAt: Timestamp(date: Date()), user: User(firstName: "Mark", lastName: "Villar",  userName: "@mark"))
            
            let firestore = NetworkCall()
            firestore.add(data: composedTweet, in: Subcollections.tweets)
            
            dismissComposeTweet()
        }
        
    }
    
    @objc func dismissComposeTweet() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ComposeTweetController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.isEmpty {
            //TextField was emptied - revert the button to disabled state
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            //TextField contains at least one character - enable the tweet button
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
        return true
    }
    
}
