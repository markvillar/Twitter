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
    
    private let refreshControl = UIRefreshControl()
    
    var tweets: [Tweet] = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        configureHierarchy()
        setupRefreshControls()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    fileprivate func setupRefreshControls() {
        refreshControl.addTarget(self, action: #selector(getData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetchin Data ...", attributes: nil)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func getData() {
        
        let database = Firestore.firestore()
        
        database.collection(Subcollections.tweets).getDocuments { [weak self] querySnapshot, error in
            
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
            self?.dataSource.apply(snapshot, animatingDifferences: true)
            
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
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
}

extension HomeController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
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
