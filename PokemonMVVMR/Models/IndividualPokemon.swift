//
//  IndividualPokeMon.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import Foundation


// MARK: - IndividualPokemon
struct IndividualPokemon: Decodable {
    let baseExperience, height, id: Int
    let name: String
    let sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height, id, name, sprites
    }
}

// MARK: - Sprites
struct Sprites: Decodable {
    let other: Other
}

// MARK: - Other
struct Other: Decodable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}


// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault, frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
