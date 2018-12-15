//
//  Character.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let description: String
    let comics: [Comic]
    let stories: [Story]
    let events: [Event]
    let series: [Series]
}

struct Comic {
    let name: String
}

struct Story {
    let name: String
    let type: String
}

struct Event {
    let name: String
}

struct Series {
    let name: String
}
