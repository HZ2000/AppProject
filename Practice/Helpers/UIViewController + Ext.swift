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


extension UITextField {
    func addBottomBorder() {
        var bottomBorder = UIView()
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomBorder)
        self.borderStyle = .none
        
        //Setup Anchors
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$").evaluate(with: self)
    }
}

extension UIControl {
    func addingShadows() {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}

