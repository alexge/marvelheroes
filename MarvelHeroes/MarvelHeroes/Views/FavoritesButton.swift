//
//  FavoritesButton.swift
//  MarvelHeroes
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class FavoritesButton: UIButton {
    
    private var character: Character?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView?.contentMode = .scaleAspectFit
    }
    
    func bind(character: Character) {
        self.character = character
        
        if character.isFavorite {
            setImage(UIImage(named: "filled_heart"), for: .normal)
        } else {
            setImage(UIImage(named: "empty_heart"), for: .normal)
        }
    }
    
    func refresh() {
        guard let character = character else { return }
        if character.isFavorite {
            setImage(UIImage(named: "filled_heart"), for: .normal)
        } else {
            setImage(UIImage(named: "empty_heart"), for: .normal)
        }
    }
}


