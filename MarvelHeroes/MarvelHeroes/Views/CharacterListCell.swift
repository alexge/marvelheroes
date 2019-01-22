//
//  CharacterListCell.swift
//  MarvelHeroes
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

protocol CharacterListCellDelegate: class {
    func favoritesButtonTapped(character: Character, indexPath: IndexPath)
}

class CharacterListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    
    private var favoritesButton = FavoritesButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    
    private var character: Character? {
        didSet {
            guard let character = character else { return }
            favoritesButton.bind(character: character)
        }
    }
    private var indexPath: IndexPath?
    
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
    
    @objc private func buttonTapped() {
        guard let character = self.character, let indexPath = self.indexPath else { return }
        delegate?.favoritesButtonTapped(character: character, indexPath: indexPath)
    }
}
