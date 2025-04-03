//
//  PokemonRepo.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import Foundation


protocol PokemonRepoActions{
    func getPokemons(offset: String, limit: String)async throws -> PokemonResponse
}

class PokemonRepo{
    private var networkManager: NetworkManagerActions!
    init(networkManager: NetworkManagerActions){
        self.networkManager = networkManager
    }
}

extension PokemonRepo: PokemonRepoActions{
    
    func getPokemons(offset: String, limit: String) async throws -> PokemonResponse {
        do{
            let params = ["offset" : offset, "limit" : limit]
            let pokemonListRequest = PokemonListRequest(paramerters: params, path: APIEndpoints.pokemonsEndPoint, type: "GET")
            let dataList = try await self.networkManager.getDataFromWebService(urlRequest: pokemonListRequest, modelType: PokemonResponse.self)
            return dataList
        } catch {
            throw error
        }
    }
    

}
