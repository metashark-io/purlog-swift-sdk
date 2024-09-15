//
//  PurLogTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 9/13/24.
//

import Foundation
import XCTest
@testable import PurLog

internal final class PurLogTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Setup code here. This method is called before each test method is invoked.
    }
    
    override func tearDown() {
        // Teardown code here. This method is called after each test method completes.
        super.tearDown()
    }

    func testInitializeConfig() {
        // Arrange
        let config = PurLogConfig(level: .INFO, env: .PROD)
        
        // Act
        Task {
         await PurLog.shared.initialize(config: config)
        }
        
        // Assert
        XCTAssertEqual(config.level, .INFO)
        XCTAssertEqual(config.env, .PROD)
    }
    
    /*func testLog_ShouldInvokeConsoleAndPostLog() {
            // Arrange
            let config = PurLogConfig(level: .INFO, env: .DEV, credentials: PurLogCredentials(projectId: "projectId", jwt: "validToken"))
            PurLog.shared.initialize(config: config)
            
            let mockURLSession = MockURLSession()
            mockURLSession.data = Data()
            mockURLSession.response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                                      statusCode: 200, httpVersion: nil, headerFields: nil)
            
            // Capture the console output
            let output = PurLog.shared.log("Test log message", level: .INFO)
            
            // Assert that console log is invoked
            XCTAssertTrue(output.contains("[INFO] Test log message"))
            
            // Assert that API log is invoked correctly
            XCTAssertEqual(mockURLSession.request?.url?.absoluteString, "https://us-central1-purlog-45f7f.cloudfunctions.net/api/create-log")
            if let bodyData = mockURLSession.request?.httpBody {
                let json = try? JSONSerialization.jsonObject(with: bodyData, options: []) as? [String: Any]
                XCTAssertEqual(json?["token"] as? String, "validToken")
                XCTAssertEqual(json?["projectId"] as? String, "projectId")
                XCTAssertEqual(json?["message"] as? String, "Test log message")
                XCTAssertEqual(json?["level"] as? String, "INFO")
            } else {
                XCTFail("Expected HTTP body to be set in the request")
            }
        }

        func testLog_ShouldNotLogForLowerLogLevel() {
            // Arrange
            let config = PurLogConfig(level: .ERROR, env: .DEV, credentials: nil)
            PurLog.shared.initialize(config: config)
            
            let output = PurLog.shared.log("Test log message", level: .INFO) // INFO is lower than ERROR
            
            // Assert that nothing is logged since log level is too low
            XCTAssertNil(output)
        }*/
}
