//
//  WebServiceManager.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import Foundation

protocol NetworkManagerActions{
    func getDataFromWebService<T: Decodable>(urlRequest: Requestable, modelType: T.Type) async throws -> T
}


class NetworkManager{
    var urlSession: NetworkSessionable
    init(urlSession: NetworkSessionable = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: NetworkManagerActions {
    func getDataFromWebService<T>(urlRequest: Requestable, modelType: T.Type) async throws -> T where T : Decodable {
        do{
            guard let request = urlRequest.createURLRequest() else{
                throw WebServiceError.invalidURL
            }
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
            if response.isValidResponse(){
                let parsedData = try JSONDecoder().decode(modelType, from: data)
                return parsedData
            }
            else{
                throw WebServiceError.invalidResponse((response as? HTTPURLResponse)?.statusCode ?? 0)
            }
        } catch {
            throw error
        }
        
    }
}

extension URLResponse{
    func isValidResponse()->Bool{
        guard let response = self as? HTTPURLResponse else { return false }
        switch response.statusCode{
        case 200...299:
            return true
        default:
            return false
        
        }
        
    }
}
