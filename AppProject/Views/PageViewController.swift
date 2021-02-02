//
//  PageViewController.swift
//  AppProject
//
//  Created by Cypress on 2/2/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newhintViewController(hint: "First"),self.newhintViewController(hint: "Second"),self.newhintViewController(hint: "Third"),self.newhintViewController(hint: "Fourth")]
    }()
    
    private func newhintViewController(hint: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(hint)HintViewController")
    }
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Skip"), for: .normal)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpOutside)
        return button
    }()
    
    let pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pageControl.frame = CGRect(x: 184, y: 828, width: 50, height: 50)
        skipButton.frame = CGRect(x: 326, y: 52, width: 62, height: 41)
    }
    
    @objc private func didTapSkipButton() {
        
    }
    


}

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
