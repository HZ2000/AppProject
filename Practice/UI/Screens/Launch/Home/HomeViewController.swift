//
//  HomeViewController.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    static let storyboardId = "HomeViewController"
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationControllerSetup()
    }
    
    // MARK: Properties
    
    private lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    private var isSlideInMenuPresented = false
    
    lazy var slidingViewController = SlidingMenuViewController()
    
    lazy var menuView: UIView = {
        let slidingVC = UIViewController.getViewController(id: "SlidingMenuViewController") as! SlidingMenuViewController
        let slidingView = slidingVC.view
        return slidingView!
    }()
    
    lazy var containerView: UIView = {
       let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray5
        } else {

        }
        return view
    }()
    
    lazy var menuBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Main-Menu-Bar-Button"), style: .done, target: self, action: #selector(didTapMenuButton))
    
    // MARK: Actions
    
    @objc private func didTapMenuButton(_ sender: Any) {
        slidingViewController.delegate = self
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.containerView.frame.origin.x = self.isSlideInMenuPresented ? 0 : self.containerView.frame.width -  self.slideInMenuPadding
            }, completion: {(finished) in
                print("Animation finished: \(finished)")
                self.isSlideInMenuPresented.toggle()
                })
        }
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        
    }
    
    // MARK: Helpers
    
    private func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.setLeftBarButton(menuBarButton, animated: false)
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        containerView.edgeTo(view)
    }

}

extension HomeViewController: SlidingMenuViewControllerDelegate {
    func signOutButton() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.containerView.frame.origin.x = self.isSlideInMenuPresented ? 0 : self.containerView.frame.width -  self.slideInMenuPadding
        }, completion: {(finished) in
            print("Animation finished: \(finished)")
            self.isSlideInMenuPresented.toggle()
            })
        view.backgroundColor = .black
    }
    
    func userButton() {
        
    }
    
    func contactsButton() {
        
    }
    
    func mediaButton() {
        
    }
}

