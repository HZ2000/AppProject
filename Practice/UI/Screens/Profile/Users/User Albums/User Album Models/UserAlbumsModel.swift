//
//  UserAlbumsModel.swift
//  Practice
//
//  Created by Cypress on 2/18/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

struct UserAlbums: Decodable {
    let userId: Int
    let id: Int
    let title: String
}
