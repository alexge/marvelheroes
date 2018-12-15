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
            if moreResults {
                tableView.tableFooterView?.isHidden = false
                delegate?.didReachBottom()
            }
        }
    }
}


class CharacterListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
}
