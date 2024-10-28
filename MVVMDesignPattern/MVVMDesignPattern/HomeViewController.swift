//
//  HomeViewController.swift
//  MVVMDesignPattern
//
//  Created by Jason Qiu on 2024/10/27.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = NetworkService.shared.currentUser {
            welcomeLabel.text = "\(currentUser.lastname) \(currentUser.firstname)"
        }
    }
}
