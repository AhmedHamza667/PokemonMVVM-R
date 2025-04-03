//
//  PokemonDetails.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import SwiftUI

struct PokemonDetails: View {
    @StateObject var viewModel = PokemonDetailsViewModel(repsitory: PokemonDetailsRepo(networkManager: NetworkManager()))
    var pokemon: Pokemon
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .frame(width: 200, height: 200)
            case .loaded:
                displayDetails()
            case .error(let error):
                displayErrorView(error: error)
            case .empty:
                initalEmpty()
            }
        }
        .padding()
        .navigationTitle(Text("Pokemons"))
        .task {
            await viewModel.getPokemonDetails(url: pokemon.url)
        }
    }
    
    
    
    func displayDetails() -> some View {
        VStack(spacing: 16) {
            if let details = viewModel.pokemonDetails {
                AsyncImage(url: URL(string: details.sprites.other.officialArtwork.frontDefault)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                        .frame(width: 200, height: 200)
                }
                
                Text(details.name.capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 8) {
                    Text("ID: \(details.id)")
                        .font(.headline)
                    Text("Height: \(details.height)")
                        .font(.headline)
                    Text("Base Experience: \(details.baseExperience)")
                        .font(.headline)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
            } else {
                Text("No details available.")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .padding()
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
    PokemonDetails(viewModel: PokemonDetailsViewModel(repsitory: PokemonDetailsRepo(networkManager: NetworkManager())), pokemon: Pokemon(name: "Name", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
