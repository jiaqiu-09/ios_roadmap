//
//  ViewController.swift
//  MVVMDesignPattern
//
//  Created by Jason Qiu on 2024/10/26.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = LoginViewModel()
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        self.userNameTextField.placeholder = "Please enter username"
        self.userNameTextField.keyboardType = .emailAddress
        
        self.passwordTextField.placeholder = "Please enter your password"
        self.passwordTextField.isSecureTextEntry = true
        
        self.userNameTextField.addTarget(self, action: #selector(usernameChanged), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    }
    
    private func bindViewModel() {
        viewModel.isLoginButtonEnabled.addObserver { [weak self] isEnabled in
            self?.loginButton.isEnabled = isEnabled
        }
    }
    
    @objc private func usernameChanged() {
        // 当用户名输入框值变化时，更新 ViewModel
        viewModel.username.value = userNameTextField.text ?? ""
    }
    
    @objc private func passwordChanged() {
        // 当用户名输入框值变化时，更新 ViewModel
        viewModel.password.value = passwordTextField.text ?? ""
    }
}

