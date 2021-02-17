//
//  Users.swift
//  Practice
//
//  Created by Cypress on 2/17/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

class Users: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    
    // MARK: Init

    required init(id: Int , name: String , username: String , email: String , phone: String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
    }
}

