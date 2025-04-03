//
//  FakeNetworkManager.swift
//  PokemonMVVMRTests
//
//  Created by Ahmed Hamza on 3/13/25.
//

import Foundation
@testable import PokemonMVVMR

class FakeNetworkManager: NetworkManagerActions{
    
    var testPath = ""
    func getDataFromWebService<T>(urlRequest: any PokemonMVVMR.Requestable, modelType: T.Type) async throws -> T where T: Decodable {
        let bundle = Bundle(for: FakeNetworkManager.self)
        guard let url = bundle.url(forResource: testPath, withExtension: "json") else {
            throw WebServiceError.invalidURL
        }
            do {
                let fileData = try Data(contentsOf: url)
                let parsedData = try JSONDecoder().decode(modelType.self, from: fileData)
                return parsedData
            } catch {
                print(error.localizedDescription)
                throw error
            }
        }
    }
