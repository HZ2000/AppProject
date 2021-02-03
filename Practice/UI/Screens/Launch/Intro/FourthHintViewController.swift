//
//  FourthHintViewController.swift
//  AppProject
//
//  Created by Cypress on 2/2/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit

class FourthHintViewController: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var doneButton: UIButton!
    
    // Properties
    
    var doneButtonTap: (() -> ())?
    weak var delegate: FourthIntroPageDelegate?
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Actions
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        doneButtonTap?()
    }
}

protocol FourthIntroPageDelegate: AnyObject {
    func didTapDoneButton()
}
