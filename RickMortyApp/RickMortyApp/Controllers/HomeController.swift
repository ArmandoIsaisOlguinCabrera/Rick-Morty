//
//  HomeController.swift
//  RickMortyApp
//
//  Created by Armando Isais Olguin Cabrera on 15/04/24.
//



import UIKit

class HomeController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let buttonCharacters: UIButton = {
        let buttonEpisodes = UIButton()
        let iconAttachment = NSTextAttachment()
        let iconString = NSAttributedString(attachment: iconAttachment)
        let attributedString = NSMutableAttributedString(string: "Characters")
        buttonEpisodes.backgroundColor = .systemBlue
        iconAttachment.image = UIImage(systemName: "person")
        attributedString.append(iconString)
        buttonEpisodes.setAttributedTitle(attributedString, for: .normal)
        buttonEpisodes.addTarget(self, action: #selector(charactersButtonTapped), for: .touchUpInside)
        buttonEpisodes.translatesAutoresizingMaskIntoConstraints = false
        return buttonEpisodes
    }()
    
    private let buttonEpisodes: UIButton = {
        let buttonEpisodes = UIButton()
        let iconAttachment = NSTextAttachment()
        let iconString = NSAttributedString(attachment: iconAttachment)
        let attributedString = NSMutableAttributedString(string: "Episodes")
        buttonEpisodes.backgroundColor = .systemGray
        iconAttachment.image = UIImage(systemName: "video")
        attributedString.append(iconString)
        buttonEpisodes.setAttributedTitle(attributedString, for: .normal)
        buttonEpisodes.addTarget(self, action: #selector(episodesButtonTapped), for: .touchUpInside)
        buttonEpisodes.translatesAutoresizingMaskIntoConstraints = false
        return buttonEpisodes
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI(){
        self.navigationItem.title = "Rick & Morty App"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(buttonCharacters)
        stackView.addArrangedSubview(buttonEpisodes)
        NSLayoutConstraint.activate([
                    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
    }
    
    @objc func charactersButtonTapped() {
        let vc = CharactersController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func episodesButtonTapped() {
        let vc = EpisodesController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
