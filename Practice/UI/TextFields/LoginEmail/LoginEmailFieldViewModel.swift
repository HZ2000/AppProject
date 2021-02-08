//
//  LoginEmailFieldViewModel.swift
//  Practice
//
//  Created by Cypress on 2/5/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginEmailFieldViewModel {
    // MARK: Input
    
    let text: BehaviorRelay<String?> = BehaviorRelay(value: nil)

    // MARK: Output
    
    let isValid: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    // MARK: Init
    
    init() {
        setupInitialBidnings()
    }
    
    // MARK: Properties
    
    private let bag = DisposeBag()
    
    // MARK: Helpers
    
    private func setupInitialBidnings() {
        text
            .map { (str) in
                return Validation.emailIsValid(str)
            }
            .bind(to: isValid)
            .disposed(by: bag)
    }
}
