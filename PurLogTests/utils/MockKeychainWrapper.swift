//
//  MockKeychainWrapper.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

@testable import PurLog

internal class MockKeychainWrapper: KeychainWrapper {
    var saveReturnStatus: Result<Void, PurLogError> = .success(())
    var getReturnStatus: Result<String, PurLogError> = .success((""))
    
    override func save(token: String, forKey key: String) -> Result<Void, PurLogError> {
        return saveReturnStatus
    }
    
    override func get(forKey key: String) -> Result<String, PurLogError> {
        return getReturnStatus
    }
}
