//
//  PurLogCredentials.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

internal struct PurLogCredentials {
    let clientId: String
    let token: String?
    let err: String?

    init(clientId: String, token: String, keychainWrapper: KeychainWrapper = KeychainWrapper.shared) {
        self.clientId = clientId
        
        let saveStatus = keychainWrapper.save(token: token, forKey: "PurLogToken")
        guard saveStatus == errSecSuccess else {
            self.err = "PurLog KeychainWrapper failed to save token with status: \(saveStatus)"
            self.token = nil
            return
        }
        
        let getStatus = keychainWrapper.get(forKey: "PurLogToken").1
        guard getStatus == errSecSuccess else {
            self.err = "PurLog KeychainWrapper failed to retrieve token with status: \(getStatus)"
            self.token = nil
            return
        }
        
        self.token = KeychainWrapper.shared.get(forKey: "PurLogToken").0
        self.err = nil
    }
}
