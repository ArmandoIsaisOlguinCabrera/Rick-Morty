//
//  CharactersControllerViewModel.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import UIKit

class CharactersControllerViewModel {
    
    var onCharactersUpdate: (()->Void)?
    var onErrorMessage: ((CharactersServiceError)->Void)?
    
    private(set) var characs: [Charac] = [] {
        didSet{
            self.onCharactersUpdate?()
        }
    }
    
    private(set) var filteredCharacters: [Charac] = []
    
    init(){
        self.fetchCharacters()
    }
    
    public func fetchCharacters(){
        let endpoint = EndPoint.fetchCharacters()
        CharactersService.fetchCharacters(with: endpoint) { [weak self] result in
            switch result{
            case .success(let characs):
                self?.characs = characs
                print("DEBUG PRINT:", "\(characs.count) characters fetched")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}

extension CharactersControllerViewModel{
    public func inSearchModel(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(_ searchBarText: String?){
        self.filteredCharacters = characs
        if let searchText = searchBarText?.lowercased(){
            guard !searchText.isEmpty else { self.onCharactersUpdate?(); return}
            self.filteredCharacters = self.filteredCharacters.filter({
                $0.name.lowercased().contains(searchText)
            })
        }
        self.onCharactersUpdate?()
    }
}
