//
//  keychain.swift
//  PurLog
//
//  Created by Grant Espanet on 9/14/24.
//

import Foundation

internal class KeychainWrapper {
    
    static let shared = KeychainWrapper()
    
    func save(token: String, forKey key: String) -> Result<Void, PurLogError> {
        let data = Data(token.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        // Add the new item
        let status = SecItemAdd(query as CFDictionary, nil)
                
        guard status == errSecSuccess else {
            return .failure(PurLogError(title: "PurLog KeychainWrapper failed to save key", message: "status: \(status)"))
        }
        return .success(())
    }
    
    func get(forKey key: String) -> Result<String, PurLogError> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess else {
            return .failure(PurLogError(title: "PurLog KeychainWrapper failed to get key", message: "status: \(status)"))
        }
        guard let data = dataTypeRef as? Data else {
            return .failure(PurLogError(title: "PurLog KeychainWrapper failed to get key", message: "dataTypeRef must be a non-null Data type"))
        }
        guard let retrievedString = String(data: data, encoding: .utf8) else {
            return .failure(PurLogError(title: "PurLog KeychainWrapper failed to get key", message: "unable to convert data to string"))
        }
        return .success(retrievedString)
    }
    
    // only used for tests
    func delete(forKey key: String) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
    
    internal func createUUIDIfNotExists() -> Result<String, PurLogError> {
        let getSessionResult = get(forKey: "PurLogSessionUUID")
        switch getSessionResult {
        case .success(let success):
            return .success(success)
        case .failure(let failure):
            let uuid = UUID().uuidString
            let saveResult = save(token: uuid, forKey: "PurLogSessionUUID")
            switch saveResult {
            case .success(let success):
                return .success(uuid)
            case .failure(let failure):
                return .failure(PurLogError.error(title: "failed to save uuid to keychain", error: failure))
            }
        }
    }

}
