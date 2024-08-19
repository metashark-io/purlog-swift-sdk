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
            XCTAssertNotNil(config.colorConfig, "ColorConfig should not be nil")
            XCTAssertNil(config.credentials, "Credentials should be nil by default")
        }
        
        func testBuilderInitializationWithDefaultValues() {
            // Act
            let config = PurLogConfig.Builder().build()
            
            // Assert
            XCTAssertEqual(config.level, PurLogLevel.VERBOSE)
            XCTAssertEqual(config.env, PurLogEnv.DEV)
            XCTAssertNotNil(config.colorConfig, "ColorConfig should not be nil")
            XCTAssertNil(config.credentials, "Credentials should be nil by default")
        }
        
        func testBuilderInitializationWithCustomValues() {
            // Arrange
            let customLevel = PurLogLevel.ERROR
            let customEnv = PurLogEnv.PROD
            let customColorConfig = PurLogColorConfig() // Customize if necessary
            let clientId = "testClientId"
            let token = "testToken"
            
            // Act
            let config = PurLogConfig.Builder()
                .setLevel(customLevel)
                .setEnv(customEnv)
                .setColorConfig(colorConfig: customColorConfig)
                .setCredentials(clientId: clientId, token: token)
                .build()
            
            // Assert
            XCTAssertEqual(config.level, customLevel)
            XCTAssertEqual(config.env, customEnv)
            //XCTAssertEqual(config.colorConfig, customColorConfig)
            XCTAssertNotNil(config.credentials, "Credentials should not be nil")
            XCTAssertEqual(config.credentials?.clientId, clientId)
            XCTAssertEqual(config.credentials?.token, token)
            XCTAssertNil(config.credentials?.err, "Credentials shouldn't have any errors")
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
            XCTAssertNotNil(config.colorConfig, "ColorConfig should not be nil")
            XCTAssertNil(config.credentials, "Credentials should be nil by default")
        }
}
