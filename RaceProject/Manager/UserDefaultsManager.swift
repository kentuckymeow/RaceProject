//
//  UserDefaultsManager.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 11.06.2023.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
       
    private let userDefaults: UserDefaults
    private let queue: DispatchQueue
       
    private init() {
        userDefaults = UserDefaults.standard
        queue = DispatchQueue(label: "userDefaultsManagerQueue", attributes: .concurrent)
    }
       
    func setValue(_ value: Any?, forKey key: String) {
        queue.async(flags: .barrier) {
            self.userDefaults.setValue(value, forKey: key)
        }
    }
       
    func getValue(forKey key: String) -> Any? {
        var result: Any?
        queue.sync {
            result = userDefaults.value(forKey: key)
        }
        return result
    }
}

