//
//  LoginViewController.swift
//  ComponentsStyleDemo
//
//  Created by Jason Qiu on 2025/1/6.
//

import Foundation
import UIKit


class LoginViewController: UIViewController {
    @IBOutlet weak var labelTitle: AppLabel!
    @IBOutlet weak var buttonLogin: AppButton!
    @IBOutlet weak var buttonReset: AppButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.setSize(of: 24, of: .bold)
        
        buttonLogin.setStyleState(.primary)
        buttonLogin.setTitle("Authenticate User", for: .normal)
        
        buttonReset.setStyleState(.secondary)
        buttonReset.setTitle("Reset Password", for: .normal)
    }
    
    
    @IBAction func buttonResetPasswordAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResetViewController") as! ResetViewController
        self.present(vc, animated: true)
    }
}
