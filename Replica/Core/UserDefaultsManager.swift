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
        case model
    }
    
//    func getBV(key: UDData) -> Bool {
//        return userDefaults.bool(forKey: key.rawValue)
//    }
//    
//    func saveBV(value: Bool, key: UDData) {
//        userDefaults.setValue(value, forKey: key.rawValue)
//    }
//    
//    func saveDV(value: Double, key: UDData) {
//        userDefaults.setValue(value, forKey: key.rawValue)
//    }
//
//    func getDV(key: UDData) -> Double {
//        return userDefaults.double(forKey: key.rawValue)
//    }
//    
//    func getSV(key: UDData) -> String {
//        return userDefaults.string(forKey: key.rawValue) ?? ""
//    }
//    
//    func saveSV(value: String, key: UDData) {
//        userDefaults.setValue(value, forKey: key.rawValue)
//    }
    
//    func saveArray(value: [Model], key: UDData) {
//        userDefaults.set(value, forKey: key.rawValue)
//    }
//    
//    func getArray(key: UDData) {
//        userDefaults.array(forKey: key.rawValue)
//    }
}
