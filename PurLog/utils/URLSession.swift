//
//  URLSession.swift
//  PurLog
//
//  Created by Grant Espanet on 9/13/24.
//

import Foundation

internal protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
