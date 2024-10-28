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
        viewModel.error.addObserver { [weak self] error in
            if (error != nil) {
                print("error: \(error!)")
            } else {
                if self?.loginButton.isEnabled == true {
                    if let homepageVC = self?.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeViewController {
                        self?.navigationController?.pushViewController(homepageVC, animated: true)
                    }
                }
                
            }
        }
    }
    
    @objc private func usernameChanged() {
        viewModel.username.value = userNameTextField.text ?? ""
    }
    
    @objc private func passwordChanged() {
        viewModel.password.value = passwordTextField.text ?? ""
    }
    
    @IBAction func login() {
        viewModel.login(username: self.userNameTextField.text!, password: self.passwordTextField.text!)
    }
}

