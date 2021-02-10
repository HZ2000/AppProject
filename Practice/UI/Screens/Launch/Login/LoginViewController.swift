//
//  LoginViewController.swift
//  Practice
//
//  Created by Cypress on 2/3/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    static let storyboardId = "LoginViewController"

    // MARK: Outlets
    
    @IBOutlet private weak var emailTextField: LoginEmailTextField! 
    @IBOutlet private weak var passwordTextField: LoginPasswordTextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailErrorImageView: UIImageView!
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var passwordErrorImageView: UIImageView!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupViewModelBindings()
        configureViewsVisibility()
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem?.isEnabled = false
    }
    
    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel?

    // MARK: Helpers
    
    private func setupViewModel() {
        viewModel = LoginViewModel()
    }
    
    private func setupViewModelBindings() {
        guard let viewModel = viewModel else { return }
 
        emailTextField.setup(viewModel: viewModel.emailFieldViewModel.value)
        passwordTextField.setup(viewModel: viewModel.passwordFieldViewModel.value)
        
        loginButton
            .rx
            .tap
            .bind(to: viewModel.loginButtonTap)
            .disposed(by: disposeBag)
        
        viewModel
            .emailErrorDescript
            .observeOn(MainScheduler.instance)
            .bind(to: emailErrorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .emailErrorDescript
            .map { (strOptional) -> Bool in
                return (strOptional == nil)
            }
            .observeOn(MainScheduler.instance)
            .bind(to: emailErrorImageView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .passwordErrorDescript
            .observeOn(MainScheduler.instance)
            .bind(to: passwordErrorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .passwordErrorDescript
            .map { (strOptional) -> Bool in
                return (strOptional == nil)
            }
            .observeOn(MainScheduler.instance)
            .bind(to: passwordErrorImageView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .loginSuccess
            .asObservable()
            .bind { _ in
                self.goToHomeScreen()
            }
            .disposed(by: disposeBag)
    }
    
    private func configureViewsVisibility() {
        emailTextField.addBottomBorder()
        emailTextField.delegate = self
        emailTextField.addingShadows()
        
        passwordTextField.addBottomBorder()
        passwordTextField.addingShadows()
        passwordTextField.delegate = self
        
        emailErrorLabel.textColor = .systemRed
        emailErrorImageView.image = UIImage(named: "Warning")
        emailErrorImageView.isHidden = true
        
        passwordErrorLabel.textColor = .systemRed
        passwordErrorImageView.image = UIImage(named: "Warning")
        passwordErrorImageView.isHidden = true
        
        loginButton.addingShadows()
    }
    
    private func goToHomeScreen() {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.viewControllers = [vc]
    }
}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        return newLength <= 25
    }
}



