//
//  tokens.swift
//  PurLog
//
//  Created by Grant Espanet on 9/14/24.
//

import Foundation


internal func refreshTokenIfExpired(projectJWT: String, sessionJWT: String, projectId: String) async {
    Task {
        let checkTokenExpResult = await checkTokenExpiration(sessionJWT: sessionJWT)
        switch checkTokenExpResult {
        case .success(let status):
            //SdkLogger.shared.log(level: .DEBUG, message: "Token status: \(status.rawValue)")
            if status == .EXPIRED {
                if !SessionTokenManager.shared.isRefreshing {
                    _ = await SessionTokenManager.shared.refreshToken(projectJWT: projectJWT, sessionJWT: sessionJWT, projectId: projectId)
                } else {
                    // TODO: queue log and retry
                }
            }
        case .failure(_):
            // this shouldn't fail
            SdkLogger.shared.log(level: .ERROR, message: "checkTokenExpiration failed")
        }
    }
}

private func checkTokenExpiration(sessionJWT: String) async -> Result<TokenStatus, PurLogError> {
    do {
        let jwt = try decode(jwtToken: sessionJWT)
        
        if let expirationTimestamp = jwt["expiration"] as? Double {
            // Convert expiration timestamp (seconds) to a Date object
            let expirationDate = Date(timeIntervalSince1970: expirationTimestamp)
            
            // Check if the token is expired
            return .success(expirationDate < Date() ? .EXPIRED : .VALID)
        } else {
            return .failure(PurLogError.error(title: "Failed to decode JWT", message: "expiration field not found", logLevel: .ERROR))
        }
    } catch {
        return .failure(PurLogError.error(title: "Failed to decode JWT", message: error.localizedDescription, logLevel: .ERROR))
    }
}

private func decode(jwtToken jwt: String) throws -> [String: Any] {
    
    enum DecodeErrors: Error {
        case badToken
        case other
    }

    func base64Decode(_ base64: String) throws -> Data {
        //SdkLogger.shared.log(level: .VERBOSE, message: "Checking If JWT is expired...")
        let base64 = base64
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
        guard let decoded = Data(base64Encoded: padded) else {
            throw DecodeErrors.badToken
        }
        return decoded
    }

    func decodeJWTPart(_ value: String) throws -> [String: Any] {
        let bodyData = try base64Decode(value)
        let json = try JSONSerialization.jsonObject(with: bodyData, options: [])
        guard let payload = json as? [String: Any] else {
            throw DecodeErrors.other
        }
        return payload
    }

    let segments = jwt.components(separatedBy: ".")
    guard segments.count >= 2 else {
        return [:]
    }
    return try decodeJWTPart(segments[1])
}
