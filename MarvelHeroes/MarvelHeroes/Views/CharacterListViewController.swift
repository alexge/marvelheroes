//
//  CharacterListViewController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

protocol CharacterListViewControllerDelegate: class {
    func didSelectCharacter(_ character: Character)
    func didReachBottom()
    func toggleFavorite(character: Character)
    func didSearch(for search: String)
    func didClearSearch()
}

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.rowHeight = 50
        }
    }
    @IBOutlet weak var searchField: UITextField?
    @IBOutlet weak var searchButton: UIButton?
    
    var searchLoadingIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    var characters = [Character]() {
        didSet {
            tableView?.reloadData()
            tableView?.tableFooterView?.isHidden = true
            searchLoadingIndicator.stopAnimating()
            searchButton?.setTitle("Search", for: .normal)
            searchButton?.isEnabled = true
        }
    }
    
    weak var delegate: CharacterListViewControllerDelegate?
    var moreResults: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
        guard let button = searchButton else { return }
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        button.addSubview(searchLoadingIndicator)
        searchLoadingIndicator.stopAnimating()
        searchLoadingIndicator.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        searchLoadingIndicator.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }
    

    @objc private func search() {
        searchButton?.setTitle(nil, for: .normal)
        searchLoadingIndicator.startAnimating()
        searchButton?.isEnabled = false
        if searchField?.text == nil || searchField?.text == "" {
            delegate?.didClearSearch()
        } else {
            delegate?.didSearch(for: searchField?.text ?? "")
        }
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCharacter(characters[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell") else { return UITableViewCell() }
        guard let listCell = cell as? CharacterListCell else { return cell }
        
        listCell.bind(character: characters[indexPath.row], indexPath: indexPath)
        listCell.delegate = self
        
        return listCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == characters.count - 1 {
            if moreResults {
                tableView.tableFooterView?.isHidden = false
                delegate?.didReachBottom()
            }
        }
    }
}

extension CharacterListViewController: CharacterListCellDelegate {
    func favoritesButtonTapped(character: Character, indexPath: IndexPath) {
        delegate?.toggleFavorite(character: character)
        tableView?.reloadRows(at: [indexPath], with: .fade)
    }
}

protocol CharacterListCellDelegate: class {
    func favoritesButtonTapped(character: Character, indexPath: IndexPath)
}
