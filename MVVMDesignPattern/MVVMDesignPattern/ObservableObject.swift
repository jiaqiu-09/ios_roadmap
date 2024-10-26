//
//  ObservableObject.swift
//  MVVMDesignPattern
//
//  Created by Jason Qiu on 2024/10/26.
//

import Foundation

class ObservableObject<T> {
    
    private var observers: [(T) -> Void] = []
    
    var value: T {
        didSet {
            observers.forEach { $0(value) }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: @escaping (T) -> Void) {
        observers.append(observer)
        observer(value)
    }
}
