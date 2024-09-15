//
//  PurLogConfigTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

import XCTest
@testable import PurLog

internal final class PurLogConfigTests: XCTestCase {
    func testDefaultInitialization() {
            // Act
            let config = PurLogConfig()
            
            // Assert
            XCTAssertEqual(config.level, PurLogLevel.VERBOSE)
            XCTAssertEqual(config.env, PurLogEnv.DEV)
            XCTAssertNil(config.projectId, "projectId should be nil by default")
        }
        
        func testBuilderInitializationWithDefaultValues() {
            // Act
            let config = PurLogConfig.Builder().build()
            
            // Assert
            XCTAssertEqual(config.level, PurLogLevel.VERBOSE)
            XCTAssertEqual(config.env, PurLogEnv.DEV)
            XCTAssertNil(config.projectId, "projectId should be nil by default")
        }
        
        func testBuilderInitializationWithCustomValues() {
            // Arrange
            let customLevel = PurLogLevel.ERROR
            let customEnv = PurLogEnv.PROD
            let projectId = "testClientId"
            let token = "testToken"
            
            // Act
            let config = PurLogConfig.Builder()
                .setLevel(customLevel)
                .setEnv(customEnv)
                .setProject(projectId: projectId, projectJWT: token)
                .build()
            
            // Assert
            XCTAssertEqual(config.level, customLevel)
            XCTAssertEqual(config.env, customEnv)
            XCTAssertNotNil(config.projectId, "projectId should not be nil")
            XCTAssertEqual(config.projectId, projectId)
        }
        
        func testBuilderInitializationWithPartialValues() {
            // Arrange
            let customLevel = PurLogLevel.DEBUG
            
            // Act
            let config = PurLogConfig.Builder()
                .setLevel(customLevel)
                .build()
            
            // Assert
            XCTAssertEqual(config.level, customLevel)
            XCTAssertEqual(config.env, PurLogEnv.DEV) // Default value
            XCTAssertNil(config.projectId, "projectId should be nil by default")
        }
}
