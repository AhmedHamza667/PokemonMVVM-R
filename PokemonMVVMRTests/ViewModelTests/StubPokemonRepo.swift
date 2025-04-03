//
//  StubPokemonRepo.swift
//  PokemonMVVMRTests
//
//  Created by Ahmed Hamza on 3/14/25.
//

import Foundation
@testable import PokemonMVVMR

class StubPokemonRepo: PokemonRepoActions{
    
    private var error: WebServiceError?
    private var pokemonResponse: PokemonResponse?
    
    func getPokemons(offset: String, limit: String) async throws -> PokemonMVVMR.PokemonResponse {
        if error != nil {
            throw error!
        }
        return pokemonResponse!
    }
    
    func setError(error:WebServiceError){
        self.error = error
    }
    
    func setPokemonResponse(pokemonResponse:PokemonResponse){
        self.pokemonResponse = pokemonResponse
    }

    
}
