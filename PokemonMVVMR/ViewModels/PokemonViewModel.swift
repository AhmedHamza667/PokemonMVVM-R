//
//  PokemonViewModel.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import Foundation
import SwiftUI

enum PokemonViewState: Equatable{
    case loading
    case loaded
    case error(Error)
    case empty
    
    static func == (lhs: PokemonViewState, rhs: PokemonViewState) -> Bool {
        switch (lhs, rhs){
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
            
        default:
            return true
        }
    }

}

final class PokemonViewModel: ObservableObject{
    @Published var pokemonList = [Pokemon]()
    @Published var viewState: PokemonViewState = .empty
    @Published var hasMoreItems: Bool = true
    @Published var isLoadingMore = false
    var offset: Int = 0
    var limit: Int = 20

    private var repsitory: PokemonRepoActions
    
    init(repsitory: PokemonRepoActions) {
        self.repsitory = repsitory
    }
    
    @MainActor
    func getPokemonList() async {
        guard hasMoreItems, !isLoadingMore else { return }
        isLoadingMore = true
        
        if pokemonList.isEmpty {
            viewState = .loading
        }
        
        do {
            let dataList = try await self.repsitory.getPokemons(offset: "\(offset)", limit: "\(limit)")
            withAnimation(nil) {
                pokemonList.append(contentsOf: dataList.results)
                self.offset += self.limit
                self.hasMoreItems = dataList.next != nil
                viewState = .loaded
            }
        } catch {
            print(error.localizedDescription)
            viewState = .error(error)
        }
        isLoadingMore = false
    }
    
    @MainActor
    func resetPokemonList() async {
        guard !isLoadingMore else { return }
        viewState = .loading
        self.offset = 0
        self.limit = 20
        self.hasMoreItems = true
        
        do {
            let dataList = try await self.repsitory.getPokemons(offset: "\(offset)", limit: "\(limit)")
            pokemonList = dataList.results
            self.hasMoreItems = dataList.next != nil
            viewState = .loaded
        } catch {
            print(error.localizedDescription)
            viewState = .error(error)
        }
    }

}
