//
//  UserAlbumPhotos.swift
//  Practice
//
//  Created by Cypress on 2/19/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

struct UserAlbumPhotos: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
