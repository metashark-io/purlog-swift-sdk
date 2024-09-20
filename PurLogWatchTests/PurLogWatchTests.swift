//
//  PurLogWatchTests.swift
//  PurLogWatchTests
//
//  Created by Grant Espanet on 9/20/24.
//

import XCTest
@testable import PurLog

final class PurLogWatchTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

