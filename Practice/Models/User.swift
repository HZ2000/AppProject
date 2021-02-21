//
//  User.swift
//  Practice
//
//  Created by Cypress on 2/17/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}

