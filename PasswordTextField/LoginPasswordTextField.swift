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
    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setSecureEntryButton()
    }
    
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
    
    func setup(viewModel: LoginPasswordFieldViewModel) {
        self.viewModel = viewModel
        
        bag = DisposeBag()
        setupViewModelBindings()
    }
    
    // MARK: Properties
    
    private var viewModel: LoginPasswordFieldViewModel?
    private var bag = DisposeBag()
    private var secureRightViewIcon: UIButton?

    // MARK: Helpers
    
    private func setupViewModelBindings() {
        guard let viewModel = viewModel else { return }
        
        rx
            .text
            .bind(to: viewModel.text)
            .disposed(by: bag)
    }
    
    private func setSecureEntryButton() {
        let button = UIButton(frame: CGRect(x: 0, y:0, width: (frame.height * 0.8), height: frame.height * 0.8))
        
        button.setImage(#imageLiteral(resourceName: "Eye"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -2, bottom: 5, right: 5)
        button.addTarget(self, action: #selector(didTapSecureEntryButton), for: .touchUpInside)
        
        rightViewMode = .always
        rightView = button
        
        self.secureRightViewIcon = button
    }
    
    @IBAction private func didTapSecureEntryButton(_ sender: Any) {
        if !isSecureTextEntry {
            isSecureTextEntry = true
            secureRightViewIcon?.setImage(#imageLiteral(resourceName: "Eye"), for: .normal)
        }
        else {
            isSecureTextEntry = false
            secureRightViewIcon?.setImage(#imageLiteral(resourceName: "Eye-Off"),for: .normal)
        }
    }
}
