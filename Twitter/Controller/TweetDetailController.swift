//
//  TweetDetailController.swift
//  Twitter
//
//  Created by Mark on 24/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

class TweetDetailController: UIViewController {
    
    override func loadView() {
        super.loadView()
        view = TweetDetail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(individualTweet: Tweet) {
        super.init(nibName: nil, bundle: nil)
        set(tweet: individualTweet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Internal Methods
    private func set(tweet: Tweet) {
        
        let viewHandle = view as! TweetDetail
        
        DispatchQueue.main.async {
            viewHandle.name.text = "\(tweet.user.firstName) \(tweet.user.lastName)"
            viewHandle.userName.text = tweet.user.userName
            viewHandle.content.text = tweet.content
        }
    }

}
