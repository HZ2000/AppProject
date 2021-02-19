//
//  UITableView + Ext.swift
//  Practice
//
//  Created by Cypress on 2/19/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}
