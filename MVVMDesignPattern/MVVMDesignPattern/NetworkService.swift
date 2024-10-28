//
//  NetworkService.swift
//  MVVMDesignPattern
//
//  Created by Jason Qiu on 2024/10/27.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    init () {}
    
    private(set) var currentUser: User?
    
    func login(username: String, password: String, completion: @escaping(Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if (username == "test@test.com" && password == "password") {
                self.currentUser = User(firstname: "Qiu", lastname: "Jason", age: 24)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
