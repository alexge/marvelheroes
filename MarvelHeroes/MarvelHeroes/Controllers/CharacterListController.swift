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
    
    var isLoading: Bool = false
    var offset: Int = 0
    var moreResults: Bool = true {
        didSet {
            listViewController.moreResults = false
        }
    }
    
    var characters = [Character]() {
        didSet {
            listViewController.characters = characters
            offset += characters.count
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
    
    func didReachBottom() {
        guard !isLoading else { return }
        isLoading = true
        requestPerformer?.fetchCharacters(offset: offset, successHandler: { [weak self] characters in
            if characters.count < 20 {
                self?.moreResults = false
            }
            DispatchQueue.main.async {
                self?.characters.append(contentsOf: characters)
            }
            }, errorHandler: {
                
        })
    }
}
