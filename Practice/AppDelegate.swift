//
//  AppDelegate.swift
//  AppProject
//
//  Created by Cypress on 2/1/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAppFlow()
        
        return true
    }
    
    // MARK: Helpers
    private func configureAppFlow() {
        guard let navController = window?.rootViewController as? UINavigationController else { return }
        
        if UserService.shared.appWasLaunched() {
            let loginVC = UIViewController.getViewController(id: LoginViewController.storyboardId)
            
            navController.viewControllers = [loginVC]
        }
    }
}

