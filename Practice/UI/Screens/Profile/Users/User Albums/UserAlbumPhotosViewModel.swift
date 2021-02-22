//
//  UserAlbumPhotosViewModel.swift
//  Practice
//
//  Created by Cypress on 2/22/21.
//  Copyright © 2021 MacBook. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa
import Alamofire

class UserAlbumPhotosListViewModel {
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
}


