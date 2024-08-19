//
//  PurLogLevel.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

/// The log level for `PurLog`
public enum PurLogLevel: String {
    /// Typically records a myriad of events throughout the application.
    case VERBOSE
    /// Information useful to developers for debugging the application.
    case DEBUG
    /// General operational entries about what's happening in the application; typically used for recording successful API executions.
    case INFO
    /// Indications that something unexpected happened, or indicative of some problem in the near future. The application is still working as expected.
    case WARN
    /// Due to a more serious problem, the software has not been able to perform some function.
    case ERROR
    /// Severe errors that cause premature termination. Expect these to be immediately followed by application exit.
    case FATAL
}
