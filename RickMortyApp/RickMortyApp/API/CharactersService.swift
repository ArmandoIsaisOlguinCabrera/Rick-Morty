//
//  CharactersService.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import Foundation

enum CharactersServiceError: Error{
    case serverError(String = "Server Error")
    case unknown(String = "Unknown Error")
    case decodingError(String = "Decoding Error")
}

class CharactersService {
    static func fetchCharacters(with endpoint: EndPoint, completion: @escaping (Result<[Charac], CharactersServiceError>)->Void) {
        guard let request = endpoint.request else {return}
        URLSession.shared.dataTask(with: request){data, resp, error in
            if let error = error {
                print(error)
                return
            }
            
            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                print("error")
            }
        
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let charData = try JSONDecoder().decode(Characs.self, from: data)
                    print(decoder)
                    print(charData)
                    completion(.success(charData.results))
                } catch let err {
                    completion(.failure(.decodingError()))
                    print(err.localizedDescription)
                }
            } else {
                completion(.failure(.unknown()))
            }
        }.resume()
        
    }
}
