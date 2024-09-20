//
//  PurLogWatchTests.swift
//  PurLogWatchTests
//
//  Created by Grant Espanet on 9/19/24.
//

import Foundation
import XCTest
@testable import PurLog

final internal class PurLogWatchTests: XCTestCase {

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

}

