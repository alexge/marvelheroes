//
//  CharacterListController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CharacterListController: NSObject {
    
    private let navController: UINavigationController
    private let listViewController: CharacterListViewController

    private let storyboard: UIStoryboard = UIStoryboard(name: "CharacterList", bundle: .main)
    
    private var isLoading: Bool = false
    private var offset: Int = 0
    private var moreResults: Bool = true {
        didSet {
            listViewController.moreResults = moreResults
        }
    }
    
    private var characters = [Character]() {
        didSet {
            listViewController.characters = characters
        }
    }
    
    init(navigationController: UINavigationController) {
        navController = navigationController
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CharacterListViewController") as? CharacterListViewController else {
            listViewController = CharacterListViewController()
            super.init()
            return
        }
        listViewController = viewController
        
        super.init()
        
        navController.setViewControllers([listViewController], animated: false)
        listViewController.delegate = self
        
        isLoading = true
        listViewController.title = "Heroes"
        fetchCharacters()
    }
    
    private func fetchCharacters(search: String? = nil, pageLoad: Bool = false, completion: (() -> Void)? = nil) {
        isLoading = true
        if !pageLoad {
            offset = 0
        }
        requestPerformer?.fetchCharacters(offset: offset, search: search) { [weak self] characters in
            self?.moreResults = characters.count == 20
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.offset += characters.count
                if pageLoad {
                    self?.characters.append(contentsOf: characters)
                } else {
                    self?.characters = characters
                }
                completion?()
            }
        }
    }
}

extension CharacterListController: CharacterListViewControllerDelegate {
    internal func didSelectCharacter(_ character: Character) {
        let detailVC = CharacterDetailViewController(character: character)
        detailVC.transitioningDelegate = self
        detailVC.delegate = self
        listViewController.present(detailVC, animated: true)
    }
    
    internal func didReachBottom() {
        guard !isLoading else { return }
        fetchCharacters(pageLoad: true)
    }
    
    internal func toggleFavorite(character: Character) {
        guard let favoritesDictionary = NSMutableDictionary(contentsOfFile: Keys.favoritesPath)
            else {
                return
        }
        
        if character.isFavorite {
            favoritesDictionary.removeObject(forKey: "\(character.id)")
        } else {
            favoritesDictionary["\(character.id)"] = character.name
        }
        
        favoritesDictionary.write(toFile: Keys.favoritesPath, atomically: true)
    }
    
    internal func didSearch(for search: String) {
        fetchCharacters(search: search) { [weak self] in
            self?.listViewController.title = "Search: \(search)"
        }
    }
    
    internal func didClearSearch() {
        fetchCharacters() { [weak self] in
            self?.listViewController.title = "Heroes"
        }
    }
}

extension CharacterListController: UIViewControllerTransitioningDelegate {
    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = presented as? CharacterDetailViewController {
            return CharacterAnimationController(type: .fadeIn)
        } else {
            return nil
        }
    }
    
    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = dismissed as? CharacterDetailViewController {
            return CharacterAnimationController(type: .fadeOut)
        } else {
            return nil
        }
    }
}

extension CharacterListController: CharacterDetailViewControllerDelegate {
    internal func favoriteButtonTapped(character: Character) {
        toggleFavorite(character: character)
    }
}
