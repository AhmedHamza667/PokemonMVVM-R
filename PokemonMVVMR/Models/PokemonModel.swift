//
//  PokemonModel.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/12/25.
//

import Foundation

struct PokemonResponse: Decodable{
    let count:Int
    let next:String?
    let previous:String?
    let results:[Pokemon]
}


struct Pokemon: Decodable, Identifiable {
    let name: String
    let url: String
    
    var id: String {
        // Extract the Pokemon ID from the URL
        let components = url.split(separator: "/")
        if let lastComponent = components.last {
            return String(lastComponent)
        }
        return name
    }
}

