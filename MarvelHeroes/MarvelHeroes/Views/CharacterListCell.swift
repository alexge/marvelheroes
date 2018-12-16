//
//  CharacterListCell.swift
//  MarvelHeroes
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CharacterListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    
    var favoritesButton = FavoritesButton()
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            favoritesButton.bind(character: character)
        }
    }
    var indexPath: IndexPath?
    
    weak var delegate: CharacterListCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(favoritesButton)
        favoritesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        favoritesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func bind(character: Character, indexPath: IndexPath) {
        self.character = character
        self.indexPath = indexPath
        nameLabel?.text = character.name
    }
    
    @objc func buttonTapped() {
        guard let character = self.character, let indexPath = self.indexPath else { return }
        delegate?.favoritesButtonTapped(character: character, indexPath: indexPath)
    }
}
