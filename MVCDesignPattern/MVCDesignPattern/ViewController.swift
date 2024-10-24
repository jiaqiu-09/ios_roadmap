//
//  ViewController.swift
//  MVCDesignPattern
//
//  Created by Jason Qiu on 2024/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.placeholder = "Please enter username"
        passwordField.placeholder = "Please enter your password"
        
        usernameField.autocapitalizationType = .words
        usernameField.keyboardType = .emailAddress
        usernameField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.isSecureTextEntry = true
        
        usernameField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    }
    
    @objc private func validateFields() {
        loginButton.isEnabled = usernameField.text != "" && passwordField.text != ""
    }
    
    @IBAction func login() {
        print("Username is \(String(describing: usernameField.text)), password is \(String(describing: passwordField.text))")
        
        NetworkService.shared.login(email: usernameField.text!, password: passwordField.text!) { success in
            DispatchQueue.main.async {
                if (success) {
                    if let homepageVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePageController") as? HomePageController {
                        self.navigationController?.pushViewController(homepageVC, animated: true)
                    }
                } else {
                    print("invalid credential")
                }
            }
            
        }
        
    }
    
}

