//
//  CharacterListController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CharacterListController {
    let listViewController: CharacterListViewController
    
    var characters = [Character]() {
        didSet {
            listViewController.characters = characters
        }
    }
    
    init(viewController: CharacterListViewController) {
        listViewController = viewController
        listViewController.delegate = self
    }
}

extension CharacterListController: CharacterListViewControllerDelegate {
    func didSelectCharacter(_ character: Character) {
        
    }
}


//extension
