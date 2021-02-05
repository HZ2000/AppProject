//
//  LoginViewController.swift
//  Practice
//
//  Created by Cypress on 2/3/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import UIKit
import RxSwift


class LoginViewController: UIViewController {
    static let storyboardId = "LoginViewController"
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var isSecureTextEntryButton: UIButton!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
    }
    
    //MARK: Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text , let password = passwordTextField.text else {
            return
        }
        
        if !email.isValidEmail {
            let alert = UIAlertController(title: "Wrong E-Mail Address", message: "Please enter correct E-Mail Address.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            present(alert,animated: true)
        } else if !password.isValidPassword {
            let alert = UIAlertController(title: "Wrong Password", message: "Please enter correct Password. It has to contain at least 8 digits , also uppercase and lowercase letters, numbers and symbols.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
            present(alert,animated: true)
        } else {
            
        }
    }
    
    @IBAction func didTapSecureEntryButton(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == false {
            passwordTextField.isSecureTextEntry = true
            isSecureTextEntryButton.setImage(#imageLiteral(resourceName: "Eye"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = false
            isSecureTextEntryButton.setImage(#imageLiteral(resourceName: "Eye-Off"),for: .normal)
        }
    }

    //MARK: Methods
    
    private func configureOutlets() {
        emailTextField.addBottomBorder()
        emailTextField.delegate = self
        emailTextField.addingShadows()
        
        passwordTextField.addBottomBorder()
        passwordTextField.addingShadows()
        passwordTextField.delegate = self
        
        loginButton.addingShadows()
    }
}

//MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 25
    }
}


