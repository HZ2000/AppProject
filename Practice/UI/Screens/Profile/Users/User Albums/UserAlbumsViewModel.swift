//
//  UserAlbumsViewModel.swift
//  Practice
//
//  Created by Cypress on 2/22/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserAlbumsViewModel {
    let title = "Albums"
    
    // MARK: Init
    
    init() {
        initialNetworkBinding()
    }
    
    // MARK: Properties

    var userAlbums: BehaviorRelay<[UserAlbum]> = BehaviorRelay(value: [])
    let bag = DisposeBag()
    
    // MARK: Helpers

    func initialNetworkBinding() {
        let url = "https://jsonplaceholder.typicode.com/albums"
        NetworkService.shared.getDataFromURL(url: url, from: [UserAlbum].self) {[weak self] (data) in
            do {
                try self?.userAlbums.accept(data.get())
            } catch {
                print(error)
            }
        }
    }
}