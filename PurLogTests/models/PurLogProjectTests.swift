//
//  PurLogProjectTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

import XCTest
@testable import PurLog

internal final class PurLogProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Clean up Keychain before each test to ensure a fresh start
        let _ = KeychainWrapper.shared.delete(forKey: "PurLogProjectJWT")
        let _ = KeychainWrapper.shared.delete(forKey: "PurLogSessionJWT")
    }
    
    override func tearDown() {
        // Clean up Keychain after each test to avoid side effects
        let _ = KeychainWrapper.shared.delete(forKey: "PurLogProjectJWT")
        let _ = KeychainWrapper.shared.delete(forKey: "PurLogSessionJWT")
        super.tearDown()
    }
    
    func testInitializationWithSuccessfulSaveAndRetrieve() {
        // Arrange
        let projectId = "projectId"
        let token = "testToken"
        
        // Act
        let mockKeychainWrapper = MockKeychainWrapper()
        let credentials = PurLogProject(projectId: projectId, projectJWT: token, keychainWrapper: mockKeychainWrapper)
        
        // Assert
        XCTAssertEqual(credentials.id, projectId)
    }
    
    func testInitializationWithSaveFailure() {
        // Arrange
        let projectId = "projectId"
        let token = "testToken"
        
        // Mock the save method to simulate a failure
        let mockKeychainWrapper = MockKeychainWrapper()
        mockKeychainWrapper.saveReturnStatus = .failure(PurLogError.error(title: "Error", message: "errSecDuplicateItem"))
        
        // Act
        let credentials = PurLogProject(projectId: projectId, projectJWT: token, keychainWrapper: mockKeychainWrapper)
        
        // Assert
        XCTAssertEqual(credentials.id, projectId)
    }
    
    func testInitializationWithGetFailure() {
        // Arrange
        let projectId = "projectId"
        let token = "testToken"
        
        // Mock the save method to succeed
        let mockKeychainWrapper = MockKeychainWrapper()
        mockKeychainWrapper.saveReturnStatus = .success(())
        
        // Mock the get method to simulate a failure
        mockKeychainWrapper.getReturnStatus = .failure(PurLogError.error(title: "Error", message: "errSecItemNotFound")) // Simulate item not found error
        
        // Act
        let credentials = PurLogProject(projectId: projectId, projectJWT: token, keychainWrapper: mockKeychainWrapper)
        
        // Assert
        XCTAssertEqual(credentials.id, projectId)
    }
}
