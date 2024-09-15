//
//  InternalLogger.swift
//  PurLog
//
//  Created by Grant Espanet on 9/14/24.
//

import Foundation
import OSLog

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
    
    public func log(level: PurLogLevel, message: String) {
        guard env == .DEV else {
            return
        }
        guard shouldLog(for: level, configLevel: configLevel) else {
            return
        }
        consoleLog(env: env, logLevel: level, message: message, isInternal: true)
    }
    
    internal func consoleLog(env: PurLogEnv, logLevel: PurLogLevel, message: String, isInternal: Bool) {
        guard env == .DEV else { return }
        let logger = Logger()
        let formattedMessage = "[\(getCurrentTimestamp())] [\(logLevel.rawValue)]\(isInternal ? " [PurLog] " : " ")\(message)"
        switch logLevel {
        case .VERBOSE:
            logger.log("⚪️ \(formattedMessage)")
        case .DEBUG:
            logger.debug("🔵 \(formattedMessage)")
        case .INFO:
            logger.info("🟢 \(formattedMessage)")
        case .WARN:
            logger.warning("🟡 \(formattedMessage)")
        case .ERROR:
            logger.error("🔴 \(formattedMessage)")
        case .FATAL:
            logger.critical("🔴🔴🔴 \(formattedMessage)")
        }
        return
    }

}

