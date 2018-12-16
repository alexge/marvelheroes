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
                let comicsJSON = dict["comics"] as? [String:Any],
                let comicsArrayJSON = comicsJSON["items"] as? [[String:Any]],
                let storiesJSON = dict["stories"] as? [String:Any],
                let storiesArrayJSON = comicsJSON["items"] as? [[String:Any]],
                let eventsJSON = dict["events"] as? [String:Any],
                let eventsArrayJSON = comicsJSON["items"] as? [[String:Any]],
                let seriesJSON = dict["series"] as? [String:Any],
                let seriesArrayJSON = comicsJSON["items"] as? [[String:Any]] {
                
                let comics = comicsListFrom(json: comicsArrayJSON)
                let stories = storiesListFrom(json: storiesArrayJSON)
                let events = eventsListFrom(json: eventsArrayJSON)
                let series = seriesListFrom(json: seriesArrayJSON)
                let character = Character(id: id, name: name, description: description, comics: comics, stories: stories, events: events, series:series)
                characterList.append(character)
            }
        }
        return characterList
    }
    
    func comicsListFrom(json: [[String:Any]]) -> [Comic] {
        var comicsList = [Comic]()
        for dict in json {
            if let name = dict["name"] as? String {
                let comic = Comic(name: name)
                comicsList.append(comic)
            }
        }
        return comicsList
    }
    
    func storiesListFrom(json: [[String:Any]]) -> [Story] {
        var storiesList = [Story]()
        for dict in json {
            if let name = dict["name"] as? String {
                let story = Story(name: name)
                storiesList.append(story)
            }
        }
        return storiesList
    }
    
    func eventsListFrom(json: [[String:Any]]) -> [Event] {
        var eventsList = [Event]()
        for dict in json {
            if let name = dict["name"] as? String {
                let event = Event(name: name)
                eventsList.append(event)
            }
        }
        return eventsList
    }
    
    func seriesListFrom(json: [[String:Any]]) -> [Series] {
        var seriesList = [Series]()
        for dict in json {
            if let name = dict["name"] as? String {
                let series = Series(name: name)
                seriesList.append(series)
            }
        }
        return seriesList
    }
}
