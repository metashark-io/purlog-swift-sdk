//
//  logging.swift
//  PurLog
//
//  Created by Grant Espanet on 9/15/24.
//

import Foundation

internal func shouldLog(for logLevel: PurLogLevel, configLevel: PurLogLevel) -> Bool {
    let levels: [PurLogLevel] = [.VERBOSE, .DEBUG, .INFO, .WARN, .ERROR, .FATAL]
    guard let currentIndex = levels.firstIndex(of: configLevel),
          let messageIndex = levels.firstIndex(of: logLevel) else {
        return false
    }
    return messageIndex >= currentIndex
}
