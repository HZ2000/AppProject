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
    
    private let userService: NetworkSericeProtocol
    
    init(userService: NetworkSericeProtocol = NetworkService()) {
        self.userService = userService
    }
    
    func fetchUsersViewModel() -> Observable<[UsersViewModel]> {
        userService.fetchUsers().map {$0.map { UsersViewModel(users: $0)} }
    }
//    
//    func fetchUsers() -> [User] {
//        let users = userService.fetchUsers().map { (users) -> User in
//            return users
//        }
//    }
}
