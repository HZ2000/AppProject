//
//  LoginViewModel.swift
//  Practice
//
//  Created by Cypress on 2/5/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias LoginCredential = (email: String?,password: String?)

class LoginViewModel {
    // MARK: Input
    
    public let loginButtonTap = PublishRelay<Void>()
    
    // MARK: Output
    
    let emailFieldViewModel = BehaviorRelay<LoginEmailFieldViewModel>(value: LoginEmailFieldViewModel())
    let passwordFieldViewModel = BehaviorRelay<LoginPasswordFieldViewModel>(value: LoginPasswordFieldViewModel())
    let emailErrorDescript = BehaviorRelay<String?>(value: nil)
    let passwordErrorDescript = BehaviorRelay<String?>(value: nil)
    let loginSuccess = PublishRelay<Bool>()
    
    // MARK: Init
    
    init() {
        setupInitialBindings()
    }
    
    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: Helpers
    
    private func setupInitialBindings() {
        loginButtonTap
            .subscribe(
                onNext: { [weak self] () in
                    self?.handleLoginTap()
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func handleLoginTap() {
        let emailErrorStr = emailFieldViewModel.value.isValid.value ? nil : Constants.LabelMessage.invalidEmail.rawValue
        let passwordErrorStr = passwordFieldViewModel.value.isValid.value ? nil : Constants.LabelMessage.invalidPassword.rawValue
        
        emailErrorDescript.accept(emailErrorStr)
        passwordErrorDescript.accept(passwordErrorStr)
        
        let loginSuccess = (emailErrorStr == nil) && (passwordErrorStr == nil)
        
        if (loginSuccess) {
            self.loginSuccess.accept((true))
            UserService.shared.setUserIsLoggedIn()
        }
    }
}
