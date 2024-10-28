//
//  LoginViewModel.swift
//  MVVMDesignPattern
//
//  Created by Jason Qiu on 2024/10/26.
//

import Foundation

class LoginViewModel {
    var username = ObservableObject<String>("")
    var password = ObservableObject<String>("")
    var isLoginButtonEnabled = ObservableObject<Bool>(false)
    var error = ObservableObject<String?>(nil)
    
    init() {
        username.addObserver { [weak self] _ in
            self?.updateLoginButtonState()
        }
        password.addObserver { [weak self] _ in
            self?.updateLoginButtonState()
        }
    }
    
    
    private func updateLoginButtonState() {
        isLoginButtonEnabled.value = !username.value.isEmpty && !password.value.isEmpty
    }
    
    
    func login(username: String, password: String) {
        NetworkService.shared.login(username: username, password: password) { [weak self] success in
            if (success) {
                self?.error.value = nil
            } else {
                self?.error.value = "Invalid credentials!"
            }
        }
    }
    
}
