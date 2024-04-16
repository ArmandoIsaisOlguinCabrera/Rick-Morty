//
//  EndPoint.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import Foundation

enum EndPoint{
    case fetchCharacters(url: String = "/api/character")
    case fetchEpisodes(url: String = "/api/episode")
    
    var request: URLRequest? {
        guard let url = self.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.path = self.path
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCharacters(let url),.fetchEpisodes(let url):
            return url
        }
    }
        
    private var httpMethod: String {
        switch self {
        case .fetchCharacters,.fetchEpisodes:
            return HTTP.Method.get.rawValue
        }
    }
    
}

