//
//  Character.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import Foundation

struct Characs: Decodable {
    let results: [Charac]
}

struct Charac: Decodable {
    let name: String
    let image: String
}
