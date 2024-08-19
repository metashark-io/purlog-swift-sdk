//
//  PurLogCredentials.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

internal struct PurLogCredentials {
    let clientId: String
    let token: String

    init(clientId: String, token: String) {
        self.clientId = clientId
        
        let keychain = KeychainWrapper()
        keychain.save(key: "PurLogToken", value: token)
        self.token = keychain.get(key: "PurLogToken") ?? ""
    }
}
