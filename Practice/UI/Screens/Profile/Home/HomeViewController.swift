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
        viewInitialState()
    }
    
    // MARK: Properties
    
    private let transiton = SlideInTransition()
    private lazy var menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Main-Menu-Bar-Button"), style: .done, target: self, action: #selector(didTapMenuButton))
    private lazy var usersTableViewController = UIViewController.getViewController(id: UsersTableViewController.storyboardId) as? UsersTableViewController
    
    // MARK: Actions
    
    @objc private func didTapMenuButton(_ sender: Any) {
        guard let menuViewController = UIViewController.getViewController(id: SlidingMenuViewController.storyboardId) as? SlidingMenuViewController else { return }
        
        menuViewController.delegate = self
        menuViewController.transitioningDelegate = self
        
        menuViewController.modalPresentationStyle = .overCurrentContext
        
        let panGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreenEdge))
        transiton.dimmingView.addGestureRecognizer(panGesture)
        
        present(menuViewController, animated: true)
    }
    
    @IBAction func didSwipeMenuScreen(_ sender: Any) {
        didTapMenuButton(self)
    }
    
    // MARK: Helpers
    
    private func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = Constants.SlidingMenu.users.rawValue
        navigationItem.setLeftBarButton(menuBarButton, animated: false)
    }
    
    private func popToLoginPage() {
        if let loginVC = UIViewController.getViewController(id: LoginViewController.storyboardId) as? LoginViewController {
            self.navigationController?.viewControllers = [loginVC, self]
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapScreenEdge() {
        dismiss(animated: true, completion: nil)
    }
    
    private func viewInitialState() {
        guard let usersVC = usersTableViewController else {return}
        DispatchQueue.main.async {
            self.addChild(usersVC)
            self.view.addSubview(usersVC.view)
            
        }
    }
}

// MARK: SlidingMenuViewControllerDelegate

extension HomeViewController: SlidingMenuViewControllerDelegate {
    func signOutButtonTapped() {
        dismiss(animated: true) {
            self.popToLoginPage()
            UserService.shared.setUserIsLoggedOut()
        }
    }
    
    func usersButtonTapped() {
        guard let usersVC = usersTableViewController else {return}
        dismiss(animated: true,completion: nil)
        navigationItem.title = Constants.SlidingMenu.users.rawValue
        self.addChild(usersVC)
        self.view.addSubview(usersVC.view)
    }
    
    func contactsButtonTapped() {
        dismiss(animated: true,completion: nil)
        navigationItem.title = Constants.SlidingMenu.contacts.rawValue
    }
    
    func mediaButtonTapped() {
        dismiss(animated: true,completion: nil)
        navigationItem.title = Constants.SlidingMenu.media.rawValue
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


