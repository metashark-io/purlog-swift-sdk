//
//  MockKeychainWrapper.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

@testable import PurLog

internal class MockKeychainWrapper: KeychainWrapper {
    var saveReturnStatus: OSStatus = errSecSuccess
    var getReturnStatus: OSStatus = errSecSuccess
    var mockToken: String? = nil
    
    override func save(token: String, forKey key: String) -> OSStatus {
        return saveReturnStatus
    }
    
    override func get(forKey key: String) -> (String?, OSStatus) {
        return (mockToken, getReturnStatus)
    }
}
