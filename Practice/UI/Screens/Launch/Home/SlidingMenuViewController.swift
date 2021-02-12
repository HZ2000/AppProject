//
//  SlidingMenuViewController.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import NavigationDrawer

class SlidingMenuViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet var slidingMenuPanGesture: UIPanGestureRecognizer!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    // MARK: Properties
    
    var interactor: Interactor? = nil
    var delegate: SlidingMenuViewControllerDelegate?
    // MARK: Actions
    
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translator = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translator, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
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

