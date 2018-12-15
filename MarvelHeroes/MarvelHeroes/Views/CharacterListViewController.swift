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
        }
    }
    
    weak var delegate: CharacterListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCharacter(characters[indexPath.row])
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterListCell") else { return UITableViewCell() }
        guard let listCell = cell as? CharacterListCell else { return cell }
        
        listCell.nameLabel?.text = characters[indexPath.row].name
        
        return listCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == characters.count - 1 {
            tableView.tableFooterView?.isHidden = false
        }
    }
}


class CharacterListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
}
