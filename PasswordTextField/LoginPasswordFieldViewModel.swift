//
//  LoginPasswordFieldViewModel.swift
//  Practice
//
//  Created by Cypress on 2/5/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginPasswordFieldViewModel {
    
    // MARK: Input
    
    let text: BehaviorRelay<String?> = BehaviorRelay(value: nil)

    // MARK: Output
    
    let isValid: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    // MARK: Init
    
    init() {
        setupInitialBindings()
    }
    
    // MARK: Properties
    
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func setupInitialBindings() {
        text
            .map { (str) in
                return Validation.passwordIsValid(str)
            }
            .bind(to: isValid)
            .disposed(by: bag)
        
        
    }
}
