//
//  PurLog.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

public class PurLog {
    
    public static let shared = PurLog()
    
    private var config: PurLogConfig = PurLogConfig(level: .VERBOSE, env: .DEV, credentials: nil)
    
    private init() { }
    
    public func initialize(config: PurLogConfig) {
        self.config = config
    }
    
    public func log(_ message: String, level: PurLogLevel) {
        guard shouldLog(for: level) else { return }
        
        consoleLog(message, level: level)
        
        if let credentials = config.credentials {
            Task {
                await asyncLog()
            }
        }
    }
    
    private func shouldLog(for level: PurLogLevel) -> Bool {
        let levels: [PurLogLevel] = [.VERBOSE, .DEBUG, .INFO, .WARN, .ERROR, .FATAL]
        guard let currentIndex = levels.firstIndex(of: config.level),
              let messageIndex = levels.firstIndex(of: config.level) else {
            return false
        }
        return messageIndex >= currentIndex
    }
    
    private func consoleLog(_ message: String, level: PurLogLevel) {
        guard config.env == .DEV else { return }
        let textColor = config.colorConfig.getTextColor(for: level)
        
        var colorString = textColor
        if let backgroundColor = config.colorConfig.getBackgroundColor(for: level) {
            colorString += backgroundColor
        }
        
        let formattedMessage = "\(colorString)[\(getCurrentTimestamp())] [\(config.level.rawValue)] \(message)\u{001B}[0;0m"
        print(formattedMessage)
    }
    
    private func asyncLog() async {
        // TODO
        /*do {
            
        } catch {
            
        }*/
    }
}
