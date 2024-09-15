//
//  MockURLSession.swift
//  PurLogTests
//
//  Created by Grant Espanet on 9/13/24.
//

import Foundation
@testable import PurLog

internal class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var request: URLRequest?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        self.request = request
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
