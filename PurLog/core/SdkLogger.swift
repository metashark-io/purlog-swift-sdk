//
//  InternalLogger.swift
//  PurLog
//
//  Created by Grant Espanet on 9/14/24.
//

import Foundation
import OSLog

@MainActor 
internal class SdkLogger {
    
    public static let shared = SdkLogger()
    
    private var env: PurLogEnv = .DEV
    private var configLevel: PurLogLevel = .VERBOSE
    private lazy var osLogger: Logger = {
        Logger()
    }()
    
    public func initialize(config: PurLogConfig) {
        self.env = config.env
        self.configLevel = config.level
    }
    
    public func log(level: PurLogLevel, message: String, metadata: [String: String] = [:]) {
        guard env == .DEV else {
            return
        }
        guard shouldLog(for: level, configLevel: configLevel) else {
            return
        }
        consoleLog(env: env, logLevel: level, message: message, metadata: metadata, isInternal: true)
    }
    
    internal func consoleLog(env: PurLogEnv, logLevel: PurLogLevel, message: String, metadata: [String: String], isInternal: Bool) {
        guard env == .DEV else { return }
        let logger = Logger()
        let formattedMessage = "[\(getCurrentTimestamp())] [\(logLevel.rawValue)]\(isInternal ? " [PurLog] " : " ")\(message)"
        let formattedMessageWithMetaData = !metadata.isEmpty ? "\(formattedMessage)\n\nmetadata: \(metadata)" : formattedMessage
        switch logLevel {
        case .VERBOSE:
            logger.log("⚪️ \(formattedMessageWithMetaData)")
        case .DEBUG:
            logger.debug("🔵 \(formattedMessageWithMetaData)")
        case .INFO:
            logger.info("🟢 \(formattedMessageWithMetaData)")
        case .WARN:
            logger.warning("🟡 \(formattedMessageWithMetaData)")
        case .ERROR:
            logger.error("🔴 \(formattedMessageWithMetaData)")
        case .FATAL:
            logger.critical("🔴🔴🔴 \(formattedMessageWithMetaData)")
        }
        return
    }
}

