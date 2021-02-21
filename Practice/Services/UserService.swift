//
//  UserService.swift
//  Practice
//
//  Created by Cypress on 2/4/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

class UserService {
    static let shared = UserService()
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Properties
    
    private let defaults = UserDefaults.standard
    
    // MARK: Methods
    
    func appWasLaunched() -> Bool {
        return defaults.bool(forKey: Constants.UserDefaultsKey.appWasLaunched.rawValue)
    }
    
    func setAppWasLaunched() {
        defaults.set(true, forKey: Constants.UserDefaultsKey.appWasLaunched.rawValue)
        defaults.synchronize()
    }
    
    func userWasLoggedIn() -> Bool {
        return defaults.bool(forKey: Constants.UserDefaultsKey.userIsLogged.rawValue)
    }

    func setUserIsLoggedIn() {
        defaults.set(true, forKey: Constants.UserDefaultsKey.userIsLogged.rawValue)
        defaults.synchronize()
    }
    
    func setUserIsLoggedOut() {
         defaults.set(false, forKey: Constants.UserDefaultsKey.userIsLogged.rawValue)
         defaults.synchronize()
     }
}
