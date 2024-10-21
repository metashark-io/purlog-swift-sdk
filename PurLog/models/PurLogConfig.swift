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
    let projectId: String?
    
    init(level: PurLogLevel = .VERBOSE, env: PurLogEnv = .DEV) {
        self.level = level
        self.env = env
        self.projectId = nil
    }
    
    private init(level: PurLogLevel = .VERBOSE, env: PurLogEnv = .DEV, projectId: String? = nil) {
        self.level = level
        self.env = env
        self.projectId = projectId
    }
    
    public class Builder {
        private var level: PurLogLevel = .VERBOSE
        private var env: PurLogEnv = .DEV
        private var projectId: String?
        
        public init() {}
        
        public func setLevel(_ level: PurLogLevel) -> Builder {
            self.level = level
            return self
        }
        
        public func setEnv(_ env: PurLogEnv) -> Builder {
            self.env = env
            return self
        }
        
        @MainActor public func setProject(projectId: String, projectJWT: String) -> Builder {
            let _ = KeychainWrapper.shared.save(token: projectJWT, forKey: "PurLogProjectJWT")
            self.projectId = projectId
            return self
        }
        
        public func build() -> PurLogConfig {
            return PurLogConfig(level: level, env: env, projectId: projectId)
        }
    }
}
