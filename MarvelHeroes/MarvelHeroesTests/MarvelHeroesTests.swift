//
//  MarvelHeroesTests.swift
//  MarvelHeroesTests
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import XCTest
@testable import MarvelHeroes

class ModelTests: XCTestCase {
    
    let character = Character(id: 1, name: "ALEX", description: "the greatest", comics: [], stories: [], events: [], series: [])
    let character2 = Character(id: 2, name: "Brian", description: "the smallest", comics: [], stories: [], events: [], series: [])

    override func setUp() {
        let favoritesDictionary = NSDictionary(dictionary: ["1":"ALEX"])
        
        favoritesDictionary.write(toFile: Keys.favoritesPath, atomically: true)
    }

    override func tearDown() {
        guard let favoritesDictionary = NSMutableDictionary(contentsOfFile: Keys.favoritesPath)
            else {
                return
        }
        favoritesDictionary.removeObject(forKey: "1")
        favoritesDictionary.write(toFile: Keys.favoritesPath, atomically: true)
    }

    func testPlistPathExists() {
        XCTAssertTrue(FileManager.default.fileExists(atPath: Keys.favoritesPath))
    }
    
    func testPlistDictionaryExists() {
        XCTAssertNotNil(NSMutableDictionary(contentsOfFile: Keys.favoritesPath))
    }
    
    func testCharacterIsFavorite() {
        XCTAssertTrue(character.isFavorite)
    }
    
    func testCharacterIsNotFavorite() {
        XCTAssertFalse(character2.isFavorite)
    }

}

class NetworkTest: XCTestCase {
    
    func testMD5Hash() {
        let hash = requestPerformer?.md5Hash(timeStamp: "1", privateKey: "abcd", publicKey: "1234")
        XCTAssertTrue(hash == "ffd275c5130566a2916217b101f26150")
    }
    
}

class JSONParserTests: XCTestCase {
    
    let jsonParser = JSONParser()
    
    let charactersJSON = [["id":1,
                           "name":"Hulk",
                           "description":"Hulk... SMASH",
                           "comics":["items":[["name":"The biggest Hulk"]]],
                           "stories":["items":[["name":"The saddest Hulk"]]],
                           "events":["items":[["name":"Hulk RAMPAGE"]]],
                           "series":["items":[["name":"Hulk stuff"]]]]]
    
    let characters = [Character(id: 1, name:"Hulk",
                                description:"Hulk... SMASH",
                                comics:[Comic(name:"The biggest Hulk")],
                                stories:[Story(name:"The saddest Hulk")],
                                events:[Event(name:"Hulk RAMPAGE")],
                                series:[Series(name:"Hulk stuff")])]
    
    func testCharacterParsing() {
        print(jsonParser.characterListFrom(json: charactersJSON))
        XCTAssertTrue(jsonParser.characterListFrom(json: charactersJSON) == characters)
    }
    
    func testComicsParsing() {
        let comicsJSON = [["name":"The biggest Hulk"]]
        XCTAssertTrue(jsonParser.comicsListFrom(json: comicsJSON) == [Comic(name: "The biggest Hulk")])
    }
    
    func testStoriesParsing() {
        let storiesJSON = [["name":"The saddest Hulk"]]
        XCTAssertTrue(jsonParser.storiesListFrom(json: storiesJSON) == [Story(name: "The saddest Hulk")])
    }
    
    func testEventsParsing() {
        let eventsJSON = [["name":"Hulk RAMPAGE"]]
        XCTAssertTrue(jsonParser.eventsListFrom(json: eventsJSON) == [Event(name: "Hulk RAMPAGE")])
    }
    
    func testSeriesParsing() {
        let seriesJSON = [["name":"Hulk stuff"]]
        XCTAssertTrue(jsonParser.seriesListFrom(json: seriesJSON) == [Series(name: "Hulk stuff")])
    }
    
}
