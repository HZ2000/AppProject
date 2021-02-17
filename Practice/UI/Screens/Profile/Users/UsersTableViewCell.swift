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

    //MARK: Outlets
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func userCellConfigure(with model: Users) {
        usernameLabel.text = "Username: \(model.username)"
        emailLabel.text = "Email: \(model.email)"
    }
    
    

}
