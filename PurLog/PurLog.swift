//
//  PurLog.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

public class PurLog {
    
    public static let shared = PurLog()
    
    private var config: PurLogConfig = PurLogConfig(level: .VERBOSE, env: .DEV)
    private var isInitialized = false
    
    public func initialize(config: PurLogConfig) async -> Result<Void, PurLogError> {
        guard !isInitialized else {
            return .failure(PurLogError.error(title: "Initialization failed", message: "Already initialized", logLevel: .WARN))
        }
        SdkLogger.shared.initialize(config: config)
        SdkLogger.shared.log(level: .VERBOSE, message: "Initializing PurLog...")
        self.config = config
        
        guard let projectId = config.projectId else {
            // Xcode logging enabled for client
            SdkLogger.shared.log(level: .INFO, message: "PurLog Initialized!")
            isInitialized = true
            return .success(())
        }
        
        var projectJWT: String?
        var sessionJWT: String?
        
        let getProjectResult = KeychainWrapper.shared.get(forKey: "PurLogProjectJWT")
        switch getProjectResult {
        case .success(let success):
            projectJWT = success
        case .failure(let failure):
            return Result.failure(.error(title: "Failed to initialize SDK", message: "Unable to retrieve project JWT from keychain. " + failure.message, logLevel: .ERROR))
        }
        guard let projectJWT = projectJWT, projectJWT != "" else {
            return Result.failure(.error(title: "Failed to initialize SDK", message: "Invalid project JWT", logLevel: .ERROR))
        }
        
        var uuid: String? = nil
        let uuidResult = KeychainWrapper.shared.get(forKey: "PurLogSessionUUID")
        switch uuidResult {
        case .success(let success):
            uuid = success
        case .failure(_):
            SdkLogger.shared.log(level: .VERBOSE, message: "PurLogSessionUUID not found in Keychain. Creating a new one...")
            let createUUIDResult = KeychainWrapper.shared.createUUIDIfNotExists()
            switch createUUIDResult {
            case .success(let success):
                uuid = success
                SdkLogger.shared.log(level: .VERBOSE, message: "PurLogSessionUUID created.")
            case .failure(_):
                break
            }
        }
        guard let uuid = uuid, uuid != "" else {
            return Result.failure(.error(title: "Failed to initialize SDK", message: "Invalid UUID", logLevel: .ERROR))
        }
                
        let getSessionResult = KeychainWrapper.shared.get(forKey: "PurLogSessionJWT")
        switch getSessionResult {
        case .success(let success):
            sessionJWT = success
        case .failure(_):
            let createTokenResult = await SessionTokenManager.shared.createToken(projectJWT: projectJWT, uuid: uuid, projectId: projectId)
            switch createTokenResult {
            case .success(let success):
                sessionJWT = success
            case .failure(let failure):
                return Result.failure(.error(title: "Failed to initialize SDK", message: "Unable to create session token. " + failure.message, logLevel: .ERROR))
            }
        }
        guard let sessionJWT = sessionJWT, sessionJWT != "" else {
            return Result.failure(.error(title: "Failed to initialize SDK", message: "Invalid session JWT", logLevel: .ERROR))
        }
        
        await refreshTokenIfExpired(projectJWT: projectJWT, sessionJWT: sessionJWT, projectId: projectId)
        SdkLogger.shared.log(level: .INFO, message: "PurLog initialized!")
        isInitialized = true
        return .success(())
    }
    
    public func log(_ message: String, level: PurLogLevel) {
        guard shouldLog(for: level, configLevel: config.level) else { return }
        
        SdkLogger.shared.consoleLog(env: config.env, logLevel: level, message: message, isInternal: false)
        
        guard config.projectId != nil else {
            return
        }
        Task {
            await postLog(config: config, urlSession: URLSession.shared, message: message)
        }
    }
}
