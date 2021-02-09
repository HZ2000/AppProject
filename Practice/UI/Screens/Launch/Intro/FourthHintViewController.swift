//
//  FourthHintViewController.swift
//  AppProject
//
//  Created by Cypress on 2/2/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class FourthHintViewController: UIViewController {
    // MARK: Outlets
    
    @IBOutlet private weak var doneButton: UIButton!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Properties
    
    var doneButtonTap: (() -> ())?
    weak var delegate: FourthIntroPageDelegate?
    
    // MARK: Actions
    
    @IBAction private func didTapDoneButton(_ sender: Any) {
        doneButtonTap?()
    }
}

//MARK: FourthIntroPageDelegate

protocol FourthIntroPageDelegate: AnyObject {
    func didTapDoneButton()
}
