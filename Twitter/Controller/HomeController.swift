//
//  HomeController.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Tweet>! = nil
    var collectionView: UICollectionView! = nil
    
    let auth = Auth.auth()
    
    var tweetListen: ListenerRegistration?
    
    var tweets: [Tweet] = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        configureHierarchy()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tweetListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tweetListen?.remove()
    }
    
    // MARK: UICollectionViewDataSource
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TweetCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Tweet>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TweetCell.reuseIdentifier,
                for: indexPath) as? TweetCell else {fatalError("Cannot create tweet cell") }
            
            // Populate the cell with our item description.
            cell.set(tweet: itemIdentifier)
            
            // Return the cell.
            return cell
        }
    }
    
}

//MARK: Navigation Setup

extension HomeController {
    
    fileprivate func setupNavigation() {
        let twitterNavigation = UIImageView(image: UIImage(named: "logo"))
        
        navigationItem.titleView = twitterNavigation
        
        let composeTweetButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTweet))
        navigationItem.rightBarButtonItem = composeTweetButton
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    @objc func composeTweet() {
        let composeTweetController = ComposeTweetController()
        let navigationController = UINavigationController(rootViewController: composeTweetController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func logout() {
        try? auth.signOut()
        print("Logged Out")
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
            
            // Add data
            var snapshot = NSDiffableDataSourceSnapshot<Section, Tweet>()
            snapshot.appendSections([.main])
            snapshot.appendItems(objects)
            self?.dataSource.apply(snapshot, animatingDifferences: false)
            
        }
        
    }
    
}

extension HomeController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
