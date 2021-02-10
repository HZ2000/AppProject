//
//  HomeViewController.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import NavigationDrawer

class HomeViewController: UIViewController {
    static let storyboardId = "HomeViewController"
    
    // MARK: Outlets
    
    @IBOutlet weak var mainMenuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var mainMenuNavBar: UINavigationBar!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: self)
        if let destinationViewController = segue.destination as? SlidingMenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = self.interactor
        }
    }
    
    // MARK: Properties
    
    private let interactor = Interactor()
    
    // MARK: Actions
    
    @IBAction func mainMenuBarButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showSlidingMenu", sender: self)
        view.isOpaque = true
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Left)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "showSlidingMenu", sender: nil)
        }
    }
    
    // MARK: Helpers

}

// MARK: UIViewControllerTransitioningDelegate

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator(direction: Direction.Left)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        view.isOpaque = false
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
