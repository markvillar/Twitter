//
//  Tweet.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation

struct Tweet: Identifiable {
    let id = UUID()
    let content: String
    //let tweetedAt: Date
    let user: User
}
