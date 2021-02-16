//
//  UIControl + Ext.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    func addingShadows() {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
