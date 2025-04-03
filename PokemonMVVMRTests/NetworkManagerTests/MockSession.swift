//
//  MockSession.swift
//  PokemonMVVMRTests
//
//  Created by Ahmed Hamza on 3/14/25.
//

import Foundation
@testable import PokemonMVVMR

class MockSession: NetworkSessionable{
    private var error: Error?
    private var data: Data?
    private var urlResponse: URLResponse?
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        if error != nil {
            throw self.error!
        }
        return (self.data!, self.urlResponse! )
    }
    func setError(error: Error) {
        self.error = error
    }
    func setData(data: Data) {
        self.data = data
    }
    func setURLResponse(urlResponse: URLResponse) {
        self.urlResponse = urlResponse
    }
    
}
 
