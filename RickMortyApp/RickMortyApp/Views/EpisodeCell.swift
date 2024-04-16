//
//  EpisodeCell.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//

import UIKit

class EpisodeCell: UITableViewCell{
    static let identifier = "EpisodeCell"
    
    // MARK: - Variables
    private(set) var episode: Episode!
    
    // MARK: - UI Components
    private var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var episodeName: UILabel = {
        let episodeName = UILabel()
        episodeName.textColor = .label
        episodeName.textAlignment = .left
        episodeName.adjustsFontSizeToFitWidth = true
        episodeName.minimumScaleFactor = 0.5
        return episodeName
    }()
    
    private var episodeTag: UILabel = {
        let episodeTag = UILabel()
        episodeTag.textColor = .label
        episodeTag.textAlignment = .left
        episodeTag.adjustsFontSizeToFitWidth = true
        episodeTag.minimumScaleFactor = 0.5
        return episodeTag
    }()
    
    private var episodeAir: UILabel = {
        let episodeAir = UILabel()
        episodeAir.textColor = .label
        episodeAir.textAlignment = .left
        episodeAir.adjustsFontSizeToFitWidth = true
        episodeAir.minimumScaleFactor = 0.5
        return episodeAir
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with episode: Episode){
        self.episode = episode
        self.episodeName.text = "Name: " + episode.name
        self.episodeTag.text = "Episode: " + episode.episode
        self.episodeAir.text = "Air: " + episode.air_date
        
    }
    
    // TODO: - Prepare to reuse
    
    // MARK: - UI Setup
    private func setupUI(){
        horizontalStackView.addArrangedSubview(episodeTag)
        horizontalStackView.addArrangedSubview(episodeName)
        horizontalStackView.addArrangedSubview(episodeAir)
        
        self.addSubview(horizontalStackView)

        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
