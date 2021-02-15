//
//  HomeViewController.swift
//  Practice
//
//  Created by Cypress on 2/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import SideMenuSwift

class HomeViewController: UIViewController {
    static let storyboardId = "HomeViewController"
    
    // MARK: Outlets
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuLabel: UILabel!
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController?.revealMenu()
    }

    
    // MARK: Properties

    lazy var menuViewController: SlidingMenuViewController = {
        if let slidingVC = UIViewController.getViewController(id: "SlidingMenuViewController") as? SlidingMenuViewController {
            slidingVC.delegate = self
            return slidingVC
        }
        return UIViewController() as! SlidingMenuViewController
    }()
    
    // MARK: Actions
    
    @IBAction func didTapMenuButton(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
    // MARK: Helpers
    
    private func popToLoginPage() {
        if let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.viewControllers = [loginVC, self]
            self.navigationController?.popViewController(animated: false)
        }
    }

}

extension HomeViewController: SlidingMenuViewControllerDelegate {
    func signOutButton() {
       
    }
    
    func userButton() {
        
    }
    
    func contactsButton() {
        
    }
    
    func mediaButton() {
        
    }
}

