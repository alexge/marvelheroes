//
//  CharacterListController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CharacterListController: NSObject {
    
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
        super.init()
        
        listViewController.delegate = self
        
        isLoading = true
        fetchCharacters()
    }
    
    func fetchCharacters() {
        requestPerformer?.fetchCharacters(offset: offset, successHandler: { [weak self] characters in
            if characters.count < 20 {
                self?.moreResults = false
            }
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.characters.append(contentsOf: characters)
            }
            }, errorHandler: {
                
        })
    }
}

extension CharacterListController: CharacterListViewControllerDelegate {
    func didSelectCharacter(_ character: Character) {
        let detailVC = CharacterDetailViewController(character: character)
        detailVC.transitioningDelegate = self
        listViewController.present(detailVC, animated: true)
    }
    
    func didReachBottom() {
        guard !isLoading else { return }
        isLoading = true
        fetchCharacters()
    }
}

extension CharacterListController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = presented as? CharacterDetailViewController {
            return CharacterAnimationController(type: .fadeIn)
        } else {
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = dismissed as? CharacterDetailViewController {
            return CharacterAnimationController(type: .fadeOut)
        } else {
            return nil
        }
    }
}
