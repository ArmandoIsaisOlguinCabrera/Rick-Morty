//
//  EpisodesControllerViewModel.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import UIKit

class EpisodesControllerViewModel {
    
    var onEpisodesUpdate: (()->Void)?
    var onErrorMessage: ((EpisodesServiceError)->Void)?
    
    private(set) var episodes: [Episode] = [] {
        didSet{
            self.onEpisodesUpdate?()
        }
    }
    
    private(set) var filteredEpisodes: [Episode] = []
    
    init(){
        self.fetchEpisodes()
    }
    
    public func fetchEpisodes(){
        let endpoint = EndPoint.fetchEpisodes()
        EpisodesService.fetchEpisodes(with: endpoint) { [weak self] result in
            switch result{
            case .success(let episodes):
                self?.episodes = episodes
                print("DEBUG PRINT:", "\(episodes.count) episodes fetched")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}

extension EpisodesControllerViewModel{
    public func inSearchModel(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(_ searchBarText: String?){
        self.filteredEpisodes = episodes
        if let searchText = searchBarText?.lowercased(){
            guard !searchText.isEmpty else { self.onEpisodesUpdate?(); return}
            self.filteredEpisodes = self.filteredEpisodes.filter({
                $0.name.lowercased().contains(searchText) || $0.episode.lowercased().contains(searchText)
            })
        }
        self.onEpisodesUpdate?()
    }
}
