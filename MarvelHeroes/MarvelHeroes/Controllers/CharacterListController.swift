//
//  CharacterListController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

class CharacterListController: NSObject {
    
    let navController: UINavigationController
    let listViewController: CharacterListViewController

    let storyboard: UIStoryboard
    
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
    
    init(navigationController: UINavigationController) {
        navController = navigationController
        storyboard = UIStoryboard(name: "CharacterList", bundle: .main)
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
        fetchCharacters()
        configureSearch()
    }
    
    private func fetchCharacters() {
        requestPerformer?.fetchCharacters(offset: offset) { [weak self] characters in
            if characters.count < 20 {
                self?.moreResults = false
            }
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.characters.append(contentsOf: characters)
            }
        }
    }
    
    private func configureSearch() {
        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearch))
        listViewController.navigationItem.setRightBarButton(item, animated: false)
    }
    
    @objc private func openSearch() {
        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "Search") as? SearchViewController else { return }
        searchVC.delegate = self
        navController.pushViewController(searchVC, animated: true)
    }
}

extension CharacterListController: CharacterListViewControllerDelegate {
    func didSelectCharacter(_ character: Character) {
        let detailVC = CharacterDetailViewController(character: character)
        detailVC.transitioningDelegate = self
        detailVC.delegate = self
        listViewController.present(detailVC, animated: true)
    }
    
    func didReachBottom() {
        guard !isLoading else { return }
        isLoading = true
        fetchCharacters()
    }
    
    func toggleFavorite(character: Character) {
        guard let favoritesPath = Bundle.main.path(forResource: "Favorites", ofType: "plist"),
            let favoritesDictionary = NSMutableDictionary(contentsOfFile: favoritesPath)
            else {
                return
        }
        
        if character.isFavorite {
            favoritesDictionary.removeObject(forKey: "\(character.id)")
        } else {
            favoritesDictionary["\(character.id)"] = character.name
        }
        
        favoritesDictionary.write(toFile: favoritesPath, atomically: true)
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

extension CharacterListController: SearchViewControllerDelegate {
    func didRequestSearch(for search: String) {
        guard let searchResultsVC = storyboard.instantiateViewController(withIdentifier: "CharacterListViewController") as? CharacterListViewController else { return }
        searchResultsVC.delegate = self
        searchResultsVC.moreResults = false
        searchResultsVC.title = "Search: \(search)"
        navController.pushViewController(searchResultsVC, animated: true)
        
        requestPerformer?.fetchCharacters(offset: 0, search: search) { characters in
            DispatchQueue.main.async {
                searchResultsVC.characters = characters
            }
        }
    }
}

extension CharacterListController: CharacterDetailViewControllerDelegate {
    func favoriteButtonTapped(character: Character) {
        toggleFavorite(character: character)
    }
}
