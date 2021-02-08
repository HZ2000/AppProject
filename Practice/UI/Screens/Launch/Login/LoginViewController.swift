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
    var isSecureTextEntryButton = UIButton()
    
    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: LoginViewModel?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupViewModelBindings()
        configureOutlets()
    }
    
    // MARK: Actions
    
    @IBAction func didTapSecureEntryButton(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == false {
            passwordTextField.isSecureTextEntry = true
            isSecureTextEntryButton.setImage(#imageLiteral(resourceName: "Eye"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = false
            isSecureTextEntryButton.setImage(#imageLiteral(resourceName: "Eye-Off"),for: .normal)
        }
    }

    // MARK: Helpers
    
    private func setupViewModel() {
        viewModel = LoginViewModel()
    }
    
    private func setupViewModelBindings() {
        guard let viewModel = viewModel else { return }
        
        loginButton
            .rx
            .tap
            .bind(to: viewModel.loginButtonTap)
            .disposed(by: disposeBag)
        
        loginButton
            .rx
            .tap
            .bind(onNext: {_ in
                if self.emailErrorLabel.text != nil {
                    self.emailErrorImageView.isHidden = false
                }
                
                if self.passwordErrorLabel.text != nil {
                    self.passwordErrorImageView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        emailTextField.setup(viewModel: viewModel.emailFieldViewModel.value)
        passwordTextField.setup(viewModel: viewModel.passwordFieldViewModel.value)
        
        viewModel
            .emailErrorDescript
            .observeOn(MainScheduler.instance)
            .bind(to: emailErrorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .passwordErrorDescript
            .observeOn(MainScheduler.instance)
            .bind(to: passwordErrorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel
            .loginSuccess
            .asObservable()
            .bind { _ in
                let vc = RedViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureOutlets() {
        emailTextField.addBottomBorder()
        emailTextField.delegate = self
        emailTextField.addingShadows()
        
        passwordTextField.addBottomBorder()
        passwordTextField.addingShadows()
        passwordTextField.delegate = self
        
        emailErrorLabel.textColor = .systemRed
        passwordErrorLabel.textColor = .systemRed
        
        emailErrorImageView.image = UIImage(named: "Warning")
        emailErrorImageView.isHidden = true
        
        passwordErrorImageView.image = UIImage(named: "Warning")
        passwordErrorImageView.isHidden = true
        
        loginButton.addingShadows()
    
        setSecureEntryButton()
    }
    
    private func setSecureEntryButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: (passwordTextField.frame.height), height: passwordTextField.frame.height))
        button.setImage(#imageLiteral(resourceName: "Eye"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -20, bottom: 0, right: 6)
        button.addTarget(self, action: #selector(didTapSecureEntryButton), for: .touchUpInside)
        passwordTextField.rightViewMode = .always
        passwordTextField.rightView = button
        self.isSecureTextEntryButton = button
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



