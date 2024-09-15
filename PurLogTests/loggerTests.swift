//
//  postLogTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 9/13/24.
//

import Foundation
import XCTest
@testable import PurLog

internal final class PostLogTests: XCTestCase {
    
    func testShouldLog_LevelFiltering() {
        // Arrange
        let config = PurLogConfig(level: .INFO, env: .DEV)
        Task {
            await _ = PurLog.shared.initialize(config: config)

            // Act & Assert
            XCTAssertTrue(shouldLog(for: .INFO, configLevel: config.level)) // INFO should log
            XCTAssertTrue(shouldLog(for: .ERROR, configLevel: config.level)) // ERROR should log
            XCTAssertFalse(shouldLog(for: .DEBUG, configLevel: config.level)) // DEBUG should not log
        }
    }
    
    /*func testConsoleLog_DevEnvironment() {
        
        // Arrange
        let config = PurLogConfig(level: .INFO, env: .DEV)
        let expectedMessage = "[INFO] Test log message"
            
            // Capture the output
        let output = consoleLog(env: config.env, logLevel: .INFO, message: "Test log message")
            
        // Assert that the message is correctly logged in DEV environment
        XCTAssertTrue(output?.contains(expectedMessage) ?? false)
    }
        
        func testConsoleLog_ProdEnvironment() {
            // Arrange
            let config = PurLogConfig(level: .INFO, env: .PROD)
            let testMsg = "Test log message"
          
            // Capture the output
            let output = consoleLog(env: config.env, logLevel: .INFO, message: testMsg)
            XCTAssertNil(output)
        }*/

    /*func testPostLog_SuccessfulLogCreation() async {
        // Arrange
        let config = PurLogConfig.Builder()
            .setLevel(.INFO)
            .setEnv(.PROD)
            .setProject(projectId: "projectId", projectJWT: "testToken")
            .build()
        
        let mockURLSession = MockURLSession()
        mockURLSession.data = Data() // Simulate empty successful response
        mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                  statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // Act
        _ = await postLog(config: config, urlSession: mockURLSession, message: "")

        // Assert
        XCTAssertEqual(mockURLSession.request?.url?.absoluteString, "https://us-central1-purlog-45f7f.cloudfunctions.net/api/logs")
        XCTAssertEqual(mockURLSession.request?.httpMethod, "POST")
        
        // Assert that the request body contains the correct data
        if let bodyData = mockURLSession.request?.httpBody {
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: []) as? [String: Any]
            XCTAssertEqual(json?["jwt"] as? String, "testToken")
            XCTAssertEqual(json?["projectId"] as? String, "projectId")
            XCTAssertEqual(json?["level"] as? String, "INFO")
            XCTAssertEqual(json?["env"] as? String, "PROD")
        } else {
            XCTFail("Expected HTTP body to be set in the request")
        }
    }

    func testPostLog_FailedNetworkRequest() async {
        // Arrange
        let config = PurLogConfig.Builder()
            .setLevel(.INFO)
            .setEnv(.PROD)
            .setProject(projectId: "projectId", projectJWT: "testToken")
            .build()
        
        let mockURLSession = MockURLSession()
        mockURLSession.error = NSError(domain: "NetworkError", code: -1, userInfo: nil) // Simulate a network failure
        
        // Act
        _ = await postLog(config: config, urlSession: mockURLSession, message: "")

        // Assert
        XCTAssertNotNil(mockURLSession.request, "Expected a network request to be made")
        XCTAssertEqual(mockURLSession.request?.url?.absoluteString, "https://us-central1-purlog-45f7f.cloudfunctions.net/api/logs")
        XCTAssertEqual(mockURLSession.request?.httpMethod, "POST")
    }*/
}
