//
//  HomeController.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

private let tweetCellIdentifier = "tweetCell"

class HomeController: UICollectionViewController {
    
    var tweets: [Tweet] = [
        Tweet(content: "just setting up my twttr", user: User(firstName: "Jack", lastName: "Dorsey", userName: "@jack")),
        Tweet(content: "Hello Twitter!", user: User(firstName: "Biz", lastName: "Stone", userName: "@biz")),
        Tweet(content: "What is twitter?", user: User(firstName: "Steve", lastName: "Woz", userName: "@woz")),
        Tweet(content: "Setting up my twittr", user: User(firstName: "Jack", lastName: "Dorsey", userName: "@jack")),
        Tweet(content: "Hey Twitter!", user: User(firstName: "Biz", lastName: "Stone", userName: "@biz"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        // Register cell classes
        self.collectionView!.register(TweetCell.self, forCellWithReuseIdentifier: tweetCellIdentifier)
    }
    
    override func loadView() {
        super.loadView()
        collectionView.backgroundColor = .systemBackground
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tweetCellIdentifier, for: indexPath) as! TweetCell
        
        cell.set(tweet: tweets[indexPath.row])
        
        return cell
    }
    
}

//MARK: CollectionViewFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let height = CGFloat(100)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}

//MARK: Navigation Setup

extension HomeController {
    
    fileprivate func setupNavigation() {
        let twitterNavigation = UIImageView(image: UIImage(named: "logo"))
        
        navigationItem.titleView = twitterNavigation
        
        let composeTweetButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(composeTweet))
        navigationItem.rightBarButtonItem = composeTweetButton
        
    }
    
    @objc func composeTweet() {
        print("Compose Tweet!")
    }
    
}
