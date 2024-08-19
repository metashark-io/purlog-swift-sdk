//
//  KeychainWrapper.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

internal class KeychainWrapper {
    
    static let shared = KeychainWrapper()
    
    func save(token: String, forKey key: String) -> OSStatus {
        let data = Data(token.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        // Add the new item
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    func get(forKey key: String) -> (String?, OSStatus) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        var token: String? = nil
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            token = String(data: data, encoding: .utf8)
        }
        return (token, status)
    }
    
    func delete(forKey key: String) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
}
