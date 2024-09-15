//
//  PurLogProject.swift
//  PurLog
//
//  Created by Grant Espanet on 8/18/24.
//

import Foundation

internal struct PurLogProject {
    let id: String // project id

    init(projectId: String, projectJWT: String, keychainWrapper: KeychainWrapper = KeychainWrapper.shared) {
        self.id = projectId
        let saveResult = KeychainWrapper.shared.save(token: projectJWT, forKey: "PurLogProjectJWT")
        switch saveResult {
        case .success(_):
            break
        case .failure(_):
            return
        }
    }
}
