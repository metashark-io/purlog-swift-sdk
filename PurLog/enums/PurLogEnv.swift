//
//  PurLogEnv.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

/// the environment for `PurLog`
public enum PurLogEnv: String {
    case DEV
    case PR
    case QA
    case STAGING
    case PROD
}
