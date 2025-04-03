//
//  PokemonDetailsRepo.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/13/25.
//

import Foundation


protocol PokemonDetailsRepoActions{
    func getIndividualPokemon(url: String)async throws -> IndividualPokemon
}

class PokemonDetailsRepo{
    private var networkManager: NetworkManagerActions!
    init(networkManager: NetworkManagerActions){
        self.networkManager = networkManager
    }
}

extension PokemonDetailsRepo: PokemonDetailsRepoActions{
        
    func getIndividualPokemon(url: String) async throws -> IndividualPokemon {
        do{
            let components = url.split(separator: "/")
            let pokemonId = components.last(where: { !$0.isEmpty }).map(String.init) ?? ""
            let pokemonListRequest = PokemonListRequest(paramerters: [:], path: APIEndpoints.pokemonsEndPoint + pokemonId, type: "GET")
            let dataList = try await self.networkManager.getDataFromWebService(urlRequest: pokemonListRequest, modelType: IndividualPokemon.self)
            return dataList
        } catch {
            throw error
        }
    }

}
