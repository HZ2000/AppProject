//
//  UIViewController + Ext.swift
//  Practice
//
//  Created by Cypress on 2/3/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

extension UIViewController {
    class func getViewController(from storyboard: Constants.StoryboardName = Constants.StoryboardName.main,id: String) -> UIViewController {
        let storyboardName = storyboard.rawValue
        
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: id)
    }
}




