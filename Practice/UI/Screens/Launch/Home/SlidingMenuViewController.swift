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
    }
    
    // MARK: Properties
    
    var interactor: Interactor? = nil

    // MARK: Actions
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        UserService.shared.setUserIsLoggedOut()
    }
    
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
}
