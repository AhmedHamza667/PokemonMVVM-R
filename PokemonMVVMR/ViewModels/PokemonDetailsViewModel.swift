//
//  PokemonDetailsViewModel.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/13/25.
//

import Foundation

enum PokemoDetailsViewState{
    case loading
    case loaded
    case error(Error)
    case empty
}

final class PokemonDetailsViewModel: ObservableObject{
    @Published var pokemonDetails: IndividualPokemon?
    @Published var viewState: PokemoDetailsViewState = .empty
    
    private var repsitory: PokemonDetailsRepoActions
    
    init(repsitory: PokemonDetailsRepoActions) {
        self.repsitory = repsitory
    }
    
 
    
    @MainActor
    func getPokemonDetails(url: String)async{
        viewState = .loading
        do {
            let dataList = try await self.repsitory.getIndividualPokemon(url: url)
            pokemonDetails = dataList
            viewState = .loaded
        } catch{
            print(error.localizedDescription)
            viewState = .error(error)
        }
    }
}
