//
//  dates.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

internal func getCurrentTimestamp() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return dateFormatter.string(from: Date())
}
