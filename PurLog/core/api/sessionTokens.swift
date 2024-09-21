//
//  token.swift
//  PurLog
//
//  Created by Grant Espanet on 9/14/24.
//

import Foundation

internal class SessionTokenManager {
    
    public static let shared = SessionTokenManager()
    
    var isRefreshing = false
    
    internal func createToken(projectJWT: String, uuid: String, projectId: String) async -> Result<String, PurLogError> {
        SdkLogger.shared.log(level: .VERBOSE, message: "calling createToken")
        isRefreshing = true
        let url = URL(string: "https://us-central1-purlog-45f7f.cloudfunctions.net/api/session_tokens")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "projectJWT": projectJWT,
            "uuid": uuid,
            "projectId": projectId
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                isRefreshing = false
                return Result.failure(.error(title: "Failed to create session JWT", message: "Non-200 status code.", logLevel: .ERROR))
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let newJwt = json["jwt"] as? String {
                let saveResult = KeychainWrapper.shared.save(token: newJwt, forKey: "PurLogSessionJWT")
                switch saveResult {
                case .success(let success):
                    SdkLogger.shared.log(level: .INFO, message: "Session JWT created!")
                    isRefreshing = false
                    return .success(newJwt)
                case .failure(let failure):
                    isRefreshing = false
                    return Result.failure(.error(title: "Failed to create session JWT", message: "Unable to save session JWT to keychain. " + failure.message, logLevel: .ERROR))
                }
            } else {
                isRefreshing = false
                return Result.failure(.error(title: "Failed to create session JWT", message: "Failed to parse the response.", logLevel: .ERROR))
            }
        } catch {
            isRefreshing = false
            return Result.failure(.error(title: "Failed to create session JWT", error: error))
        }
    }
    
    internal func refreshToken(projectJWT: String, sessionJWT: String, projectId: String) async -> Result<String, PurLogError> {
        SdkLogger.shared.log(level: .VERBOSE, message: "refreshing session JWT...")
        isRefreshing = true
        let url = URL(string: "https://us-central1-purlog-45f7f.cloudfunctions.net/api/session_tokens/refresh")!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "projectJWT": projectJWT,
            "sessionJWT": sessionJWT,
            "projectId": projectId
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                isRefreshing = false
                return Result.failure(.error(title: "Failed to refresh session JWT", message: "Non-200 status code.", logLevel: .ERROR))
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let newJwt = json["jwt"] as? String {
                let saveResult = KeychainWrapper.shared.save(token: newJwt, forKey: "PurLogSessionJWT")
                switch saveResult {
                case .success(let success):
                    isRefreshing = false
                    SdkLogger.shared.log(level: .INFO, message: "Session JWT refreshed!")
                    return .success(newJwt)
                case .failure(let failure):
                    isRefreshing = false
                    return Result.failure(.error(title: "Failed to refresh session JWT", message: "Unable to save jwt to keychain. " + failure.message, logLevel: .ERROR))
                }
            } else {
                isRefreshing = false
                return Result.failure(.error(title: "Failed to refresh session JWT", message: "Failed to parse the response.", logLevel: .ERROR))
            }
        } catch {
            isRefreshing = false
            return Result.failure(.error(title: "Failed to refresh session JWT", error: error))
        }
    }
}
