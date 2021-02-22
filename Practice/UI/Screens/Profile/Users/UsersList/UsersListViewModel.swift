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
import Alamofire

class UsersListViewModel {
    let title = "Users"
    
    // MARK: Init
    
    init() {
        initialNetworkBinding()
    }
    
    // MARK: Properties
    
    var users: BehaviorRelay<[User]> = BehaviorRelay(value: [])
    let bag = DisposeBag()
    
    // MARK: Helpers
    
    func initialNetworkBinding() {
        let url = "https://jsonplaceholder.typicode.com/users"
        NetworkService.shared.getDataFromURL(url: url, from: [User].self) {[weak self] (data) in
            do {
                try self?.users.accept(data.get())
            } catch {
                print(error)
            }
        }
    }
}
