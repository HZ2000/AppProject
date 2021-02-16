//
//  HomeViewController.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    static let storyboardId = "HomeViewController"
        
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationControllerSetup()
    }
    
    // MARK: Properties
    
    let transiton = SlideInTransition()
    lazy var menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Main-Menu-Bar-Button"), style: .done, target: self, action: #selector(didTapMenuButton))
    
    // MARK: Actions
    
    @objc private func didTapMenuButton(_ sender: Any) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "SlidingMenuViewController") as? SlidingMenuViewController else { return }
        menuViewController.delegate = self
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    @IBAction func didSwipeMenuScreen(_ sender: Any) {
        didTapMenuButton(self)
    }
    
    // MARK: Helpers
    
    private func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Users"
        navigationItem.setLeftBarButton(menuBarButton, animated: false)
    }
    
    private func popToLoginPage() {
        if let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.viewControllers = [loginVC, self]
            self.navigationController?.popViewController(animated: false)
        }
    }

}

// MARK: SlidingMenuViewControllerDelegate

extension HomeViewController: SlidingMenuViewControllerDelegate {
    func signOutButton() {
        dismiss(animated: true, completion: nil)
        self.popToLoginPage()
        UserService.shared.setUserIsLoggedOut()
    }
    
    func userButton() {
        dismiss(animated: true, completion: nil)
        navigationItem.title = "Users"
    }
    
    func contactsButton() {
        dismiss(animated: true, completion: nil)
        navigationItem.title = "Contacts"
    }
    
    func mediaButton() {
        dismiss(animated: true, completion: nil)
        navigationItem.title = "Media"
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}


