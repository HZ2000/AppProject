//
//  Constants.swift
//  Practice
//
//  Created by Cypress on 2/3/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    enum StoryboardName: String {
        case main = "Main"
    }
    
    enum UserDefaultsKey: String {
        case appWasLaunched = "appWasLaunched"
        case userIsLogged = "userIsLogged"
    }
    
    enum LabelMessage: String {
        case invalidPassword = "Invalid Password"
        case invalidEmail = "Invalid Email"
    }
    
    enum SlidingMenu: String {
        case users = "Users"
        case contacts = "Contacts"
        case media = "Media"
    }
}



