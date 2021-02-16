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
        delegate?.usersButtonTapped()
    }

    @IBAction func didTapContactsButton(_ sender: Any) {
        delegate?.contactsButtonTapped()
    }
    
    @IBAction func didTapMediaButton(_ sender: Any) {
        delegate?.mediaButtonTapped()
    }
    
    @IBAction func didTapSignOutButton(_ sender: Any) {
        delegate?.signOutButtonTapped()
    }
}

protocol SlidingMenuViewControllerDelegate: AnyObject {
    func usersButtonTapped()
    func contactsButtonTapped()
    func mediaButtonTapped()
    func signOutButtonTapped()
}

