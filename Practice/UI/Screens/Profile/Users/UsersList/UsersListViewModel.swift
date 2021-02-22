//
//  UsersListViewModel.swift
//  Practice
//
//  Created by Cypress on 2/21/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UsersListViewModel {
    let title = "Users"
    
    var users: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    let bag = DisposeBag()
    
    init() {
        //getUserData()
    }

//    func initialNetworkBinding() {
//        let urlString = "https://jsonplaceholder.typicode.com/users"
//        NetworkService.shared.getDataFromURL(url: urlString, from: User) { (Result<Decodable, Error>) in
//            <#code#>
//        }
//    }
}
