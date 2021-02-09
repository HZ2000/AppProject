//
//  LoginEmailTextField.swift
//  Practice
//
//  Created by Cypress on 2/8/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginEmailTextField: UITextField {
    // MARK: View Life Cycle

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
        
        return bounds.offsetBy(dx: 5, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        
        return bounds.offsetBy(dx: 5, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        
        return bounds.offsetBy(dx: 5, dy: 0)
    }
    
    // MARK: Methods
    
    func setup(viewModel: LoginEmailFieldViewModel) {
        self.viewModel = viewModel
        
        bag = DisposeBag()
        setupViewModelBindings()
    }
    
    // MARK: Properties
    
    private var viewModel: LoginEmailFieldViewModel?
    private var bag = DisposeBag()
    
    // MARK: Helpers
    
    private func setupViewModelBindings() {
        guard let viewModel = viewModel else { return }
        
        rx
            .text
            .bind(to: viewModel.text)
            .disposed(by: bag)
    }
    
}
