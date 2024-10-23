//
//  NetworkService.swift
//  MVCDesignPattern
//
//  Created by Jason Qiu on 2024/10/23.
//
import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    private(set) var currentUser: User?
    
    func login(email: String, password: String, completion: @escaping(Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            if (email == "test@test.com" && password == "password") {
                self.currentUser = User(firstname: "Qiu", lastName: "Jason", email: email, age: 30)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
