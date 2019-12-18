//
//  User.swift
//  Twitter
//
//  Created by Mark on 17/12/2019.
//  Copyright © 2019 Twitter. All rights reserved.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let userName: String
}
