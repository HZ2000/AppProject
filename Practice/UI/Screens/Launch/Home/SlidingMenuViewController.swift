//
//  SlidingMenuViewController.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class SlidingMenuViewController: UIViewController  {
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    // MARK: Properties
    
    var delegate: SlidingMenuViewControllerDelegate?
    
    // MARK: Actions

    @IBAction func swipeMenuPanGesture(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapUsersButton(_ sender: Any) {
        delegate?.userButton()
    }

    @IBAction func didTapContactsButton(_ sender: Any) {
        delegate?.contactsButton()
    }
    
    @IBAction func didTapMediaButton(_ sender: Any) {
        delegate?.mediaButton()
    }
    
    @IBAction func didTapSignOutButton(_ sender: Any) {
        delegate?.signOutButton()
    }
}

protocol SlidingMenuViewControllerDelegate: AnyObject {
    func userButton()
    func contactsButton()
    func mediaButton()
    func signOutButton()
}

