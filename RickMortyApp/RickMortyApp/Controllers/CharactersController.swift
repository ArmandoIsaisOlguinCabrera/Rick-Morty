//
//  CharactersController.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import UIKit

class CharactersController: UIViewController {
    
    private let viewModel: CharactersControllerViewModel
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        return tv
    }()
    
    init(_ viewModel: CharactersControllerViewModel = CharactersControllerViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupSearchController()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.viewModel.onCharactersUpdate = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupUI(){
        self.navigationItem.title = "Characters"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func setupSearchController(){
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Ingresa el nombre del personaje"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

//MARK: - TableView Functions

extension CharactersController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchController.searchBar.text)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            fatalError("Error")
        }
        let inSearchMode = self.viewModel.inSearchModel(searchController)
        let charac = inSearchMode ? self.viewModel.filteredCharacters[indexPath.row] : self.viewModel.characs[indexPath.row]
        cell.configure(with: charac)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.viewModel.inSearchModel(searchController)
        return inSearchMode ? self.viewModel.filteredCharacters.count : self.viewModel.characs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
