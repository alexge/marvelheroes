//
//  Models.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

struct Character: Equatable {
    let id: Int
    let name: String
    let description: String
    let comics: [Comic]
    let stories: [Story]
    let events: [Event]
    let series: [Series]
    
    var isFavorite: Bool {
        if let favoritesDictionary = NSDictionary(contentsOfFile: Keys.favoritesPath),
            name == favoritesDictionary["\(id)"] as? String {
            return true
        } else {
            return false
        }
    }
}

struct Comic: Equatable {
    let name: String
}

struct Story: Equatable {
    let name: String
}

struct Event: Equatable {
    let name: String
}

struct Series: Equatable {
    let name: String
}
