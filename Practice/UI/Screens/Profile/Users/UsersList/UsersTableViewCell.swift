//
//  UsersTableViewCell.swift
//  Practice
//
//  Created by Cypress on 2/17/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    static let storyboardId = "UsersTableViewCell"
    
    // MARK: Outlets
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Helpers
    
    public func userCellConfigure(with model: User) {
        usernameLabel.text = "User: \(model.username)"
        emailLabel.text = "Email: \(model.email)"
    }
    
    // FIX - Life Cycle
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = UIColor(red: 65.0/255.0, green: 199.0/255.0, blue: 219.0/255.0, alpha: 1)
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
}
