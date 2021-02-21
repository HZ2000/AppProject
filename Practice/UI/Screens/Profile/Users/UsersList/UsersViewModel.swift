//
//  UsersViewModel.swift
//  Practice
//
//  Created by Hayk Zakaryan on 2/21/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct UsersViewModel {
    // MARK: Properties
    private let users: User
    
    var displayUsername: String {
        return "User : \(users.username)"
    }
    
    var displayEmail: String {
        return "Email : \(users.email)"
    }
    
    init(users: User) {
        self.users = users
    }
}
