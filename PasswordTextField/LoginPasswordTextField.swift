//
//  LoginPasswordTextField.swift
//  Practice
//
//  Created by Cypress on 2/8/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginPasswordTextField: UITextField {
    
    // MARK: Methods
    
    func setup(viewModel: LoginPasswordFieldViewModel) {
        self.viewModel = viewModel
        
        bag = DisposeBag()
        setupViewModelBindings()
    }
    
    // MARK: Properties
    
    private var viewModel: LoginPasswordFieldViewModel?
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
