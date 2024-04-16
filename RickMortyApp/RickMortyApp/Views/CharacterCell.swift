//
//  CharacterCell.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import UIKit

class CharacterCell: UITableViewCell{
    static let identifier = "CharacterCell"
    
    // MARK: - Variables
    private(set) var charac: Charac!
    
    // MARK: - UI Components
    
    private let characterPreview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .black
        return imageView
    }()
    
    private var characterName: UILabel = {
        let characterName = UILabel()
        characterName.textColor = .label
        characterName.textAlignment = .left
        characterName.font = .systemFont(ofSize: 22, weight: .semibold)
        characterName.text = "Loading"
        return characterName
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with charac: Charac){
        self.charac = charac
        self.characterName.text = charac.name
        DispatchQueue.global().async { [weak self] in
            let logoSTR = charac.image
            if let logoURL = URL(string: logoSTR),
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data:imageData) {
                DispatchQueue.main.async {
                    self?.characterPreview.image = logoImage
                }
            }
        }
    }
    
    // TODO: - Prepare to reuse
    
    // MARK: - UI Setup
    private func setupUI(){
        self.addSubview(characterPreview)
        self.addSubview(characterName)
        characterPreview.translatesAutoresizingMaskIntoConstraints = false
        characterName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterPreview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            characterPreview.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            characterPreview.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            characterPreview.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            characterName.leadingAnchor.constraint(equalTo: characterPreview.trailingAnchor, constant: 16),
            characterName.centerYAnchor.constraint(equalTo:self.centerYAnchor)
            
        ])
    }
}
