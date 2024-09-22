//
//  logging.swift
//  PurLog
//
//  Created by Grant Espanet on 9/13/24.
//

import Foundation

internal func postLog(projectId: String, env: PurLogEnv, logLevel: PurLogLevel, urlSession: URLSessionProtocol, message: String, metadata: [String: String], deviceInfo: [String: String], appVersion: String) async -> Result<Void, PurLogError> {
    var projectJWT: String?
    var sessionJWT: String?
    
    let getProjectResult = KeychainWrapper.shared.get(forKey: "PurLogProjectJWT")
    switch getProjectResult {
    case .success(let success):
        projectJWT = success
    case .failure(let failure):
        return Result.failure(.error(title: "Failed to create log", message: "Unable to retrieve project jwt from keychain. " + failure.message, logLevel: .ERROR))
    }
    guard let projectJWT = projectJWT, projectJWT != "" else {
        return Result.failure(.error(title: "Failed to create log", message: "Invalid project JWT", logLevel: .ERROR))
    }
    
    let getSessionResult = KeychainWrapper.shared.get(forKey: "PurLogSessionJWT")
    switch getSessionResult {
    case .success(let success):
        sessionJWT = success
    case .failure(let failure):
        return Result.failure(.error(title: "Failed to create log", message: "Unable to retrieve session jwt from keychain. " + failure.message, logLevel: .ERROR))
    }
    guard let sessionJWT = sessionJWT, sessionJWT != "" else {
        return Result.failure(.error(title: "Failed to create log", message: "Invalid session JWT", logLevel: .ERROR))
    }
    
    
    await refreshTokenIfExpired(projectJWT: projectJWT, sessionJWT: sessionJWT, projectId: projectId)
    let url = URL(string: "https://us-central1-purlog-45f7f.cloudfunctions.net/api/logs")!
    
    let logData: [String: Any] = [
        "projectJWT": projectJWT,
        "sessionJWT": sessionJWT,
        "projectId": projectId,
        "message": message,
        "level": logLevel.rawValue,
        "env": env.rawValue,
        "deviceInfo": deviceInfo,
        "metadata": metadata,
        "appVersion": appVersion
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: logData, options: [])
        request.httpBody = jsonData
        
        let (_, response) = try await urlSession.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return .success(())
        } else {
            return Result.failure(.error(title: "Failed to create log", message: "Bad response.", logLevel: .ERROR))
        }
    } catch {
        return Result.failure(.error(title: "Failed to create log", error: error))
    }
}
