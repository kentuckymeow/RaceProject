//
//  UserDefaultsManager.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 11.06.2023.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
        
    private let userDefaults: UserDefaults
        
    private init() {
        userDefaults = UserDefaults.standard
    }
        
    func setValue(_ value: Any?, forKey key: String) {
        userDefaults.setValue(value, forKey: key)
    }
        
    func getValue(forKey key: String) -> Any? {
        return userDefaults.value(forKey: key)
    }
}
