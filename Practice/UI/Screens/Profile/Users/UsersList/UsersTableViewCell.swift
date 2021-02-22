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
    
    // MARK: View Life Cycle
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            if #available(iOS 13.0, *) {
                contentView.backgroundColor = .systemGray4
            } else {
                // Fallback on earlier versions
            }
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
    
    // MARK: Helpers
    
    public func userCellConfigure(with model: User) {
        usernameLabel.text = "User: \(model.username)"
        emailLabel.text = "Email: \(model.email)"
    }
}
