//
//  UserAlbumPhotosViewModel.swift
//  Practice
//
//  Created by Cypress on 3/1/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserAlbumPhotosViewModel {
    
    // MARK: Init
    
    init() {
        initialNetworkBinding()
    }
    
    // MARK: Properties

    var userAlbumPhotos: BehaviorRelay<[UserAlbumPhoto]> = BehaviorRelay(value: [])
    let bag = DisposeBag()
    
    // MARK: Helpers

    func initialNetworkBinding() {
        let url = "https://jsonplaceholder.typicode.com/photos"
        NetworkService.shared.getDataFromURL(url: url, from: [UserAlbumPhoto].self) {[weak self] (data) in
            do {
                try self?.userAlbumPhotos.accept(data.get())
            } catch {
                print(error)
            }
        }
    }
    
    func getPhotos(from model: [UserAlbumPhoto] ,with indexPath: IndexPath) -> [UserAlbumPhoto] {
        let originIndex = indexPath.row + 1
        let filteredModel = model.filter { $0.albumId >= originIndex * 50 - 50 && $0.albumId < originIndex * 50 }.map {$0}
        return filteredModel
    }
}

