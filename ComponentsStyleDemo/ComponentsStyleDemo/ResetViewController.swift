//
//  ResetViewController.swift
//  ComponentsStyleDemo
//
//  Created by Jason Qiu on 2025/1/7.
//

import Foundation
import UIKit

class ResetViewController: UIViewController {
    @IBOutlet weak var label: AppLabel!
    @IBOutlet weak var emali: AppTextField!
    @IBOutlet weak var password: AppTextField!
    @IBOutlet weak var passwordConfirmation: AppTextField!
    @IBOutlet weak var resetButton: AppButton!
    
    override func viewDidLoad() {
        label.setSize(of: 24, of: .bold)
        label.text = "Reset Password"
        
        emali.placeholder = "Email"
        password.placeholder = "Password"
        passwordConfirmation.placeholder = "Password Confirmation"
        
        resetButton.setStyleState(.primary)
        resetButton.setTitle("Reset Password", for: .normal)
    }
    
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        if let navigationController = navigationController {
            // 如果有导航控制器，使用 pop 方法返回
            navigationController.popViewController(animated: true)
        } else {
            // 如果是模态页面，使用 dismiss 方法返回
            dismiss(animated: true, completion: nil)
        }
    }
}
