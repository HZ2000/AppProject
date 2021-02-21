//
//  NetworkServiceProtocol.swift
//  Practice
//
//  Created by Hayk Zakaryan on 2/21/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkSericeProtocol {
    func fetchUsers() -> Observable<[User]>
    func fetchAlbums() -> Observable<[UserAlbum]>
    func fetchUserAlbumPhotos() -> Observable<[UserAlbumPhoto]>
}
