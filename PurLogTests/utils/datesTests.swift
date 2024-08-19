//
//  datesTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

import XCTest
@testable import PurLog

internal final class PurLogDatesTests: XCTestCase {
    func testGetCurrentTimestamp() {
            // Arrange
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            let expectedDate = Date()
            
            // Act
            let timestamp = getCurrentTimestamp()

            // Assert
            let actualDate = dateFormatter.date(from: timestamp)
            XCTAssertNotNil(actualDate, "The timestamp should be correctly formatted to a valid date.")
            
            // Assert that the difference between the expected and actual date is within a reasonable range (e.g., 1 second)
            let timeDifference = expectedDate.timeIntervalSince(actualDate!)
            XCTAssertLessThanOrEqual(abs(timeDifference), 1.0, "The generated timestamp should match the current date within a second.")
        }
}
