//
//  PurLogConfig.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

public struct PurLogConfig {
    let level: PurLogLevel
    let env: PurLogEnv
    let colorConfig: PurLogColorConfig
    //let credentials: PurLogCredentials?
    
    init(level: PurLogLevel = .VERBOSE, env: PurLogEnv = .DEV, credentials: PurLogCredentials? = nil) {
        self.level = level
        self.env = env
        self.colorConfig = PurLogColorConfig()
        //self.credentials = credentials
    }
    
    public class Builder {
        private var level: PurLogLevel = .VERBOSE
        private var env: PurLogEnv = .DEV
        private var colorConfig = PurLogColorConfig()
        //private var credentials: PurLogCredentials?
        
        public init() {}
        
        public func setLevel(_ level: PurLogLevel) -> Builder {
            self.level = level
            return self
        }
        
        public func setEnv(_ env: PurLogEnv) -> Builder {
            self.env = env
            return self
        }
        
        public func setColorConfig(colorConfig: PurLogColorConfig) -> Builder {
            self.colorConfig = colorConfig
            return self
        }
        
        /*public func setCredentials(clientId: String, token: String) -> Builder {
            self.credentials = PurLogCredentials(clientId: clientId, token: token)
            return self
        }*/
        
        public func build() -> PurLogConfig {
            return PurLogConfig(level: level, env: env/*, credentials: credentials*/)
        }
    }
}
