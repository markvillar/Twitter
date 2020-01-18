//
//  Tweet.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation
import Firebase

struct Tweet: Codable, Identifiable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let content: String
    let createdAt: Timestamp
    let user: User
}
