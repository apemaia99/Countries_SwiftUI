//
//  NetworkingService.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

actor NetworkingService {
    
    func fetchObject<T: Codable>(for url: URL) async throws -> T {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw Error.request
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension NetworkingService {
    enum Error: LocalizedError {
        case request
        
        var errorDescription: String? {
            switch self {
            case .request:
                return "Bad Request"
            }
        }
    }
}
