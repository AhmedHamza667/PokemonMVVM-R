//
//  ContentView.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PokemonViewModel(repsitory: PokemonRepo(networkManager: NetworkManager()))
    var body: some View {
        NavigationStack{
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                        .frame(width: 200, height: 200)
                case .loaded:
                    displayList()
                case .error(let error):
                    displayErrorView(error: error)
                case .empty:
                    initalEmpty()
                }
            }
            .padding()
            .navigationTitle(Text("Pokemons"))
            .task {
                await viewModel.getPokemonList()
            }
        }
    }
    
    @ViewBuilder func displayList()-> some View{
        List {
            ForEach(viewModel.pokemonList) { pokemon in
                NavigationLink{
                    PokemonDetails(pokemon: pokemon)
                } label: {
                    PokemonListCell(pokemon: pokemon)
                }
            }
            
            if viewModel.hasMoreItems {
                HStack {
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.getPokemonList()
                        }
                    }) {
                        if viewModel.isLoadingMore {
                            ProgressView()
                                .frame(height: 40)
                        } else {
                            Text("Load More")
                                .foregroundColor(.blue)
                                .frame(height: 40)
                        }
                    }
                    .disabled(viewModel.isLoadingMore)
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .refreshable {
            Task {
                await viewModel.resetPokemonList()
            }
        }
        .listStyle(.grouped)
    }

    
    @ViewBuilder func displayErrorView(error: Error)-> some View{
        VStack{
            Image(systemName: "network.slash")
                .foregroundColor(.red)
                .font(.custom("AvenirNext-Bold", size: 72))
                .padding()
                Text("\(error.localizedDescription)")
                    .font(.body)
        }
    }
    
    @ViewBuilder func initalEmpty()-> some View{
        VStack{
            Image(systemName: "exclamationmark.circle")
                .foregroundColor(.red)
                .font(.custom("AvenirNext-Bold", size: 72))
                .padding()
                Text("List is empty")
                    .font(.body)
        }
    }

}


#Preview {
    ContentView()
}
