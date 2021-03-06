//
//  TweetDetail.swift
//  Twitter
//
//  Created by Mark on 24/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

class TweetDetail: UIView {
    
    //MARK: Object Initialisation
    let userProfile: UIImageView = {
        let defaultImage = UIImage(imageLiteralResourceName: "default")
        let size = CGRect(x: 0, y: 0, width: 80, height: 80)
        let profile = UIImageView(frame: size)
        
        profile.image = defaultImage
        profile.layer.borderColor = UIColor.lightGray.cgColor
        profile.layer.borderWidth = 0.5
        profile.layer.masksToBounds = false
        profile.layer.borderColor = UIColor.black.cgColor
        profile.layer.cornerRadius = size.height/2
        profile.clipsToBounds = true
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    
    let name: UILabel = {
        let name = UILabel()
        name.text = "Unknown"
        name.textColor = .darkGray
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let userName: UILabel = {
        let userName = UILabel()
        userName.text = "@unknown"
        userName.textColor = .lightGray
        userName.translatesAutoresizingMaskIntoConstraints = false
        return userName
    }()
    
    let content: UITextView = {
        let content = UITextView()
        content.text = "Tweet not available"
        content.textAlignment = .left
        content.font = UIFont.systemFont(ofSize: 15)
        content.isScrollEnabled = false
        content.isSelectable = false
        content.isEditable = false
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    func set(username: String, name: String, content: String) {
        self.name.text = name
        self.userName.text = username
        self.content.text = content
    }
    
    //MARK: Initialiser
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Setup
    fileprivate func setupView() {
        
        backgroundColor = .systemBackground
        
        let subViews:[UIView] = [userProfile, name, userName, content]
        
        subViews.forEach { view in
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            userProfile.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            userProfile.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userProfile.widthAnchor.constraint(equalToConstant: 80),
            userProfile.heightAnchor.constraint(equalTo: userProfile.widthAnchor, multiplier: 1.0/1.0),
            
            name.topAnchor.constraint(equalTo: userProfile.topAnchor),
            name.leadingAnchor.constraint(equalTo: userProfile.trailingAnchor, constant: 8),
            
            userName.topAnchor.constraint(equalTo: name.topAnchor),
            userName.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 8),
            
            content.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0),
            content.leadingAnchor.constraint(equalTo: userProfile.trailingAnchor, constant: 8),
            content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
    }
    
}
