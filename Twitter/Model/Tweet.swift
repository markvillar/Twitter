//
//  Tweet.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation
import Firebase

struct Tweet: Identifiable, Codable {
    let id = UUID()
    let content: String
    let createdAt: Timestamp
    let user: User
}
