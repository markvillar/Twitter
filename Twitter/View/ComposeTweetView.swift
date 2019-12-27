//
//  ComposeTweetView.swift
//  Twitter
//
//  Created by Mark on 18/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import UIKit

class ComposeTweetView: UIView {
    
    let tweetText: UITextView = {
        let textview = UITextView()
        textview.isScrollEnabled = false
        textview.textAlignment = .left
        textview.font = .systemFont(ofSize: 19)
        textview.autocorrectionType = .default
        textview.autocapitalizationType = .none
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
        addSubview(tweetText)
        
        NSLayoutConstraint.activate([
            tweetText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tweetText.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tweetText.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tweetText.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    fileprivate func setupView() {
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
}
