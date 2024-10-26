//
//  ViewController.swift
//  MVVMDesignPattern
//
//  Created by Jason Qiu on 2024/10/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.userNameTextField.placeholder = "Please enter username"
        self.userNameTextField.keyboardType = .emailAddress
        
        self.passwordTextField.placeholder = "Please enter your password"
        self.passwordTextField.isSecureTextEntry = true
    }
}

