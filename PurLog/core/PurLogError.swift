//
//  PurLogError.swift
//  PurLog
//
//  Created by Grant Espanet on 9/14/24.
//

import Foundation

@MainActor
final public class PurLogError: Error {
    let title: String
    let message: String
    
    private init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    static internal func error(title: String, message: String, logLevel: PurLogLevel = .ERROR) -> PurLogError {
        SdkLogger.shared.log(level: logLevel, message: title + ". " + message)
        return PurLogError(title: title, message: message)
    }

    static internal func error(title: String, error: Error, logLevel: PurLogLevel = .ERROR) -> PurLogError {
        let message = "\(error.localizedDescription)"
        SdkLogger.shared.log(level: logLevel, message: title + ". " + message)
        return PurLogError(title: title, message: message)
    }
}
