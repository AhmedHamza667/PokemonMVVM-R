//
//  PokemonListCell.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import SwiftUI

struct PokemonListCell: View {
    var pokemon: Pokemon
    var body: some View {
        VStack(alignment: .leading){
            Text(pokemon.name.capitalized)
                .font(.title)
                .bold()
            Text("\(pokemon.url)")
                .font(.caption)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PokemonListCell(pokemon: Pokemon(name: "name", url: "url.com"))
}
