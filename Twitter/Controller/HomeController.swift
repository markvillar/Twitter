//
//  HomeController.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase

private let tweetCellIdentifier = "tweetCell"

class HomeController: UICollectionViewController {
    
    var tweetListen: ListenerRegistration?
    
    var tweets: [Tweet] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        // Register cell classes
        self.collectionView!.register(TweetCell.self, forCellWithReuseIdentifier: tweetCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tweetListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tweetListen?.remove()
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
        
        let composeTweetButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTweet))
        navigationItem.rightBarButtonItem = composeTweetButton
        
    }
    
    @objc func composeTweet() {
        
        let composeTweetController = ComposeTweetController()
        let navigationController = UINavigationController(rootViewController: composeTweetController)
        present(navigationController, animated: true, completion: nil)
        
    }
    
    func tweetListener() {
        
        let database = Firestore.firestore()
        
        self.tweetListen = database.collection(Subcollections.tweets).addSnapshotListener { [weak self] querySnapshot, error in
            
            guard let snapshots = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            var objects: [Tweet] = []
            
            for document in snapshots {
                guard let object = try? document.decode(as: Tweet.self) else { return }
                objects.append(object)
            }
            
            self?.tweets = objects
        }
        
    }
    
}
