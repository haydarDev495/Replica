//
//  UserDefaultsManager.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 13.10.23.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults()
    
    enum UDData: String {
        case saveDataToRealm
    }
    
    func getBV(key: UDData) -> Bool {
        return userDefaults.bool(forKey: key.rawValue)
    }
    
    func saveBV(value: Bool, key: UDData) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }
}
