//
//  SearchViewController.swift
//  MarvelHeroes
//
//  Created by Alex on 12/16/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func didRequestSearch(for search: String)
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var submitButton: UIButton?
    @IBOutlet weak var warningLabel: UILabel?
    
    weak var delegate: SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        submitButton?.addTarget(self, action: #selector(search), for: .touchUpInside)
    }
    
    @objc private func search() {
        if searchTextField?.text == nil || searchTextField?.text == "" {
            warningLabel?.isHidden = false
            return
        }
        delegate?.didRequestSearch(for: searchTextField?.text ?? "")
    }
}
