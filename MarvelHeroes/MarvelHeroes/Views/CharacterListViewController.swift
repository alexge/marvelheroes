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
}

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.rowHeight = 50
        }
    }
    
    var characters = [Character]() {
        didSet {
            tableView?.reloadData()
            tableView?.tableFooterView?.isHidden = true
        }
    }
    
    weak var delegate: CharacterListViewControllerDelegate?
    var moreResults: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Heroes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
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
