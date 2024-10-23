//
//  HomePageController.swift
//  MVCDesignPattern
//
//  Created by Jason Qiu on 2024/10/23.
//

import UIKit

class HomePageController: UIViewController {
    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = NetworkService.shared.currentUser {
            label.text = "\(currentUser.lastName) \(currentUser.firstname)"
        }
    }
}
