//
//  LoginViewController.swift
//  Practice
//
//  Created by Cypress on 2/3/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .red
        label.clipsToBounds = false
        label.font = UIFont(name: "System", size: 50)
        label.text = "Login View Controller"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        _ = loginLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        _ = loginLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 0).isActive = true
    }
    
    

}
