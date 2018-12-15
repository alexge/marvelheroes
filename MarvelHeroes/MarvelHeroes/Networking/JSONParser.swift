//
//  JSONParser.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

class JSONParser {
    
    func characterListFrom(json: [[String:Any]]) -> [Character] {
        var characterList = [Character]()
        for dict in json {
            if let id = dict["id"] as? Int,
                let name = dict["name"] as? String,
                let description = dict["description"] as? String,
                let comics = dict["id"] as? Int,
                let stories = dict["id"] as? Int,
                let events = dict["id"] as? Int,
                let series = dict["id"] as? Int {
                
                let character = Character(id: id, name: name, description: description, comics: [], stories: [], events: [], series:[])
                characterList.append(character)
            }
        }
        return characterList
    }
}
