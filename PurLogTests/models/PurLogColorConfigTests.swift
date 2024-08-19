//
//  PurLogColorConfigTests.swift
//  PurLogTests
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

import XCTest
@testable import PurLog

internal final class PurLogColorConfigTests: XCTestCase {
    func testDefaultTextColorMapping() {
        // Arrange
        let colorConfig = PurLogColorConfig()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .VERBOSE), PurLogTextColor.WHITE.rawValue)
        XCTAssertEqual(colorConfig.getTextColor(for: .DEBUG), PurLogTextColor.BLUE.rawValue)
        XCTAssertEqual(colorConfig.getTextColor(for: .INFO), PurLogTextColor.GREEN.rawValue)
        XCTAssertEqual(colorConfig.getTextColor(for: .WARN), PurLogTextColor.YELLOW.rawValue)
        XCTAssertEqual(colorConfig.getTextColor(for: .ERROR), PurLogTextColor.RED.rawValue)
        XCTAssertEqual(colorConfig.getTextColor(for: .FATAL), PurLogTextColor.MAGENTA.rawValue)
    }
    
    func testDefaultBackgroundColorMapping() {
        // Arrange
        let colorConfig = PurLogColorConfig()
        
        // Assert
        XCTAssertNil(colorConfig.getBackgroundColor(for: .VERBOSE))
        XCTAssertNil(colorConfig.getBackgroundColor(for: .DEBUG))
        XCTAssertNil(colorConfig.getBackgroundColor(for: .INFO))
        XCTAssertNil(colorConfig.getBackgroundColor(for: .WARN))
        XCTAssertNil(colorConfig.getBackgroundColor(for: .ERROR))
        XCTAssertNil(colorConfig.getBackgroundColor(for: .FATAL))
    }
    
    func testBuilderSetVerboseTextColor() {
        // Arrange
        let customColor = PurLogTextColor.CYAN
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setVerboseTextColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .VERBOSE), customColor.rawValue)
    }
    
    func testBuilderSetVerboseBackgroundColor() {
        // Arrange
        let customColor = PurLogBackgroundColor.BLACK
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setVerboseBackgroundColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getBackgroundColor(for: .VERBOSE), customColor.rawValue)
    }
    
    func testBuilderSetDebugTextColor() {
        // Arrange
        let customColor = PurLogTextColor.CYAN
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setDebugTextColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .DEBUG), customColor.rawValue)
    }
    
    func testBuilderSetDebugBackgroundColor() {
        // Arrange
        let customColor = PurLogBackgroundColor.BLACK
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setDebugBackgroundColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getBackgroundColor(for: .DEBUG), customColor.rawValue)
    }
    
    func testBuilderSetInfoTextColor() {
        // Arrange
        let customColor = PurLogTextColor.CYAN
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setInfoTextColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .INFO), customColor.rawValue)
    }
    
    func testBuilderSetInfoBackgroundColor() {
        // Arrange
        let customColor = PurLogBackgroundColor.BLACK
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setInfoBackgroundColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getBackgroundColor(for: .INFO), customColor.rawValue)
    }
    
    func testBuilderSetWarnTextColor() {
        // Arrange
        let customColor = PurLogTextColor.CYAN
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setWarnTextColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .WARN), customColor.rawValue)
    }
    
    func testBuilderSetWarnBackgroundColor() {
        // Arrange
        let customColor = PurLogBackgroundColor.BLACK
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setWarnBackgroundColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getBackgroundColor(for: .WARN), customColor.rawValue)
    }
    
    func testBuilderSetErrorTextColor() {
        // Arrange
        let customColor = PurLogTextColor.CYAN
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setErrorTextColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .ERROR), customColor.rawValue)
    }
    
    func testBuilderSetErrorBackgroundColor() {
        // Arrange
        let customColor = PurLogBackgroundColor.BLACK
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setErrorBackgroundColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getBackgroundColor(for: .ERROR), customColor.rawValue)
    }
    
    func testBuilderSetFatalTextColor() {
        // Arrange
        let customColor = PurLogTextColor.CYAN
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setFatalTextColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getTextColor(for: .FATAL), customColor.rawValue)
    }
    
    func testBuilderSetFatalBackgroundColor() {
        // Arrange
        let customColor = PurLogBackgroundColor.BLACK
        
        // Act
        let colorConfig = PurLogColorConfig.Builder()
            .setFatalBackgroundColor(color: customColor)
            .build()
        
        // Assert
        XCTAssertEqual(colorConfig.getBackgroundColor(for: .FATAL), customColor.rawValue)
    }
}
