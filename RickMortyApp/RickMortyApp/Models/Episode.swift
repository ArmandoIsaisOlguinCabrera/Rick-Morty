//
//  Episode.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import Foundation

struct Episodes: Decodable {
    let results: [Episode]
}

struct Episode: Decodable {
    let name: String
    let episode: String
    let air_date: String
}

