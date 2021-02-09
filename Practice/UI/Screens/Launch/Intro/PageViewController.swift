//
//  PageViewController.swift
//  AppProject
//
//  Created by Cypress on 2/2/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    // MARK: Properties
    
    private let vcsIdentifier = "HintViewController"
    private var skipButton: UIButton!
    private var pageControl: UIPageControl!
    private lazy var orderedViewControllers: [UIViewController] = {
        return getAllViewControllers()
    }()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupInitalViews()
        configureDelegation()
        setupInitialVCs()
    }
    
    // MARK: View life cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserService.shared.setAppWasLaunched()
    }
    
    // MARK: Helpers
    
    private func setupInitialVCs() {
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func configureDelegation() {
        delegate = self
        dataSource = self
    }
    
    private func setupInitalViews() {
        setupPageControl()
        setupSkipButton()
    }
    
    private func setupPageControl() {
        let pageControl = UIPageControl()
        
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        let bottomConst = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        let leadingConst = pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -120)
        let trailingConst = pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 120)
        
        NSLayoutConstraint.activate([bottomConst,leadingConst,trailingConst])
        
        self.pageControl = pageControl
    }
    
    private func setupSkipButton() {
        let button = UIButton()
        
        view.addSubview(button)

        button.setImage(#imageLiteral(resourceName: "Skip"), for: .normal)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        let topConst = NSLayoutConstraint(item: button, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 40)
        let trailingConst = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        
        NSLayoutConstraint.activate([topConst,trailingConst])
        
        self.skipButton = button
    }
    
    @objc private func didTapSkipButton() {
        gotToLoginScreen()
    }
    
    private func getAllViewControllers() -> [UIViewController] {
        var VCsToReturn = [UIViewController]()
        let storyboardsNameBase = ["First","Second","Third","Fourth"]

        for storyboardNameIter in storyboardsNameBase {
            let vcId = storyboardNameIter + vcsIdentifier
            let vcToAppend = UIViewController.getViewController(id: vcId)
            
            if let fourthVC = vcToAppend as? FourthHintViewController {
                fourthVC.doneButtonTap = { [weak self] () in
                    self?.gotToLoginScreen()
                }
            }
            
            VCsToReturn.append(vcToAppend)
        }
        
        return VCsToReturn
    }
    
    private func gotToLoginScreen() {
        let loginVC = UIViewController.getViewController(id: LoginViewController.storyboardId)
        
        navigationController?.pushViewController(loginVC, animated: true)
    }
}

// MARK: UIPageViewControllerDelegate,UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        DispatchQueue.main.async {
            self.pageControl.currentPage -= 1
            self.pageControl.updateCurrentPageDisplay()
            if(previousIndex == 4) {
                self.skipButton.isHidden = true
            }
            else {
                self.skipButton.isHidden = false
            }
        }
        guard previousIndex >= 0 else  {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderViewControllersCount = orderedViewControllers.count
        DispatchQueue.main.async {
            
            self.pageControl.currentPage += 1
            self.pageControl.updateCurrentPageDisplay()
            if(nextIndex == 4) {
                self.skipButton.isHidden = true
            }
            else {
                self.skipButton.isHidden = false
            }
        }
        guard orderViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
