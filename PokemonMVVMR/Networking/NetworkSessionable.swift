//
//  NetworkSessionable.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/13/25.
//

import Foundation


protocol NetworkSessionable{
    func data(for request:URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSessionable{
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        do{
            return try await self.data (for: request)
        }catch{
            throw error
        }
    }
}
