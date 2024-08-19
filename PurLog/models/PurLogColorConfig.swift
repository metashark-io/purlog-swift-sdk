//
//  PurLogColors.swift
//  PurLog
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

public struct PurLogColorConfig {
    private var textColorMapping: [PurLogLevel: String] = [
        .VERBOSE: PurLogTextColor.WHITE.rawValue,
        .DEBUG: PurLogTextColor.BLUE.rawValue,
        .INFO: PurLogTextColor.GREEN.rawValue,
        .WARN: PurLogTextColor.YELLOW.rawValue,
        .ERROR: PurLogTextColor.RED.rawValue,
        .FATAL: PurLogTextColor.MAGENTA.rawValue
    ]
    
    private var backgroundColorMapping: [PurLogLevel: String?] = [
        .VERBOSE: nil,
        .DEBUG: nil,
        .INFO: nil,
        .WARN: nil,
        .ERROR: nil,
        .FATAL: nil
    ]
    
    public init() {}
    
    private mutating func setTextColor(for level: PurLogLevel, color: PurLogTextColor) {
        textColorMapping[level] = color.rawValue
    }
    
    private mutating func setBackgroundColor(for level: PurLogLevel, color: PurLogBackgroundColor) {
        backgroundColorMapping[level] = color.rawValue
    }
    
    public func getTextColor(for level: PurLogLevel) -> String {
        return textColorMapping[level]!
    }
    
    public func getBackgroundColor(for level: PurLogLevel) -> String? {
        return backgroundColorMapping[level]! // this non-optional assertion still returns a `String?` type since it was a `String??`
    }
    
    public class Builder {
        private var colorConfig = PurLogColorConfig()
        
        public init() {}
        
        public func setVerboseTextColor(color: PurLogTextColor) -> Builder {
            colorConfig.setTextColor(for: .VERBOSE, color: color)
            return self
        }
        
        public func setVerboseBackgroundColor(color: PurLogBackgroundColor) -> Builder {
            colorConfig.setBackgroundColor(for: .VERBOSE, color: color)
            return self
        }
        
        public func setDebugTextColor(color: PurLogTextColor) -> Builder {
            colorConfig.setTextColor(for: .DEBUG, color: color)
            return self
        }
        
        public func setDebugBackgroundColor(color: PurLogBackgroundColor) -> Builder {
            colorConfig.setBackgroundColor(for: .DEBUG, color: color)
            return self
        }
        
        public func setInfoTextColor(color: PurLogTextColor) -> Builder {
            colorConfig.setTextColor(for: .INFO, color: color)
            return self
        }
        
        public func setInfoBackgroundColor(color: PurLogBackgroundColor) -> Builder {
            colorConfig.setBackgroundColor(for: .INFO, color: color)
            return self
        }
        
        public func setWarnTextColor(color: PurLogTextColor) -> Builder {
            colorConfig.setTextColor(for: .WARN, color: color)
            return self
        }
        
        public func setWarnBackgroundColor(color: PurLogBackgroundColor) -> Builder {
            colorConfig.setBackgroundColor(for: .WARN, color: color)
            return self
        }
        
        public func setErrorTextColor(color: PurLogTextColor) -> Builder {
            colorConfig.setTextColor(for: .ERROR, color: color)
            return self
        }
        
        public func setErrorBackgroundColor(color: PurLogBackgroundColor) -> Builder {
            colorConfig.setBackgroundColor(for: .ERROR, color: color)
            return self
        }
        
        public func setFatalTextColor(color: PurLogTextColor) -> Builder {
            colorConfig.setTextColor(for: .FATAL, color: color)
            return self
        }
        
        public func setFatalBackgroundColor(color: PurLogBackgroundColor) -> Builder {
            colorConfig.setBackgroundColor(for: .FATAL, color: color)
            return self
        }
        
        public func build() -> PurLogColorConfig {
            return colorConfig
        }
    }
}
