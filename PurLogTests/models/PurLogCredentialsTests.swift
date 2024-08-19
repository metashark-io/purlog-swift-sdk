//
//  PurLogCredentialsTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

import XCTest
@testable import PurLog

internal final class PurLogCredentialsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Clean up Keychain before each test to ensure a fresh start
        let _ = KeychainWrapper.shared.delete(forKey: "PurLogToken")
    }
    
    override func tearDown() {
        // Clean up Keychain after each test to avoid side effects
        let _ = KeychainWrapper.shared.delete(forKey: "PurLogToken")
        super.tearDown()
    }
    
    func testInitializationWithSuccessfulSaveAndRetrieve() {
        // Arrange
        let clientId = "testClientId"
        let token = "testToken"
        
        // Act
        let credentials = PurLogCredentials(clientId: clientId, token: token)
        
        // Assert
        XCTAssertEqual(credentials.clientId, clientId)
        XCTAssertEqual(credentials.token, token)
        XCTAssertNil(credentials.err, "Error should be nil when save and retrieve succeed")
    }
    
    func testInitializationWithSaveFailure() {
        // Arrange
        let clientId = "testClientId"
        let token = "testToken"
        
        // Mock the save method to simulate a failure
        let mockKeychainWrapper = MockKeychainWrapper()
        mockKeychainWrapper.saveReturnStatus = errSecDuplicateItem // Simulate duplicate item error
        
        // Act
        let credentials = PurLogCredentials(clientId: clientId, token: token, keychainWrapper: mockKeychainWrapper)
        
        // Assert
        XCTAssertEqual(credentials.clientId, clientId)
        XCTAssertNil(credentials.token, "Token should be nil when save fails")
        XCTAssertEqual(credentials.err, "PurLog KeychainWrapper failed to save token with status: \(errSecDuplicateItem)", "Error should match the simulated failure")
    }
    
    func testInitializationWithGetFailure() {
        // Arrange
        let clientId = "testClientId"
        let token = "testToken"
        
        // Mock the save method to succeed
        let mockKeychainWrapper = MockKeychainWrapper()
        mockKeychainWrapper.saveReturnStatus = errSecSuccess
        
        // Mock the get method to simulate a failure
        mockKeychainWrapper.getReturnStatus = errSecItemNotFound // Simulate item not found error
        
        // Act
        let credentials = PurLogCredentials(clientId: clientId, token: token, keychainWrapper: mockKeychainWrapper)
        
        // Assert
        XCTAssertEqual(credentials.clientId, clientId)
        XCTAssertNil(credentials.token, "Token should be nil when get fails")
        XCTAssertEqual(credentials.err, "PurLog KeychainWrapper failed to retrieve token with status: \(errSecItemNotFound)", "Error should match the simulated failure")
    }
}
