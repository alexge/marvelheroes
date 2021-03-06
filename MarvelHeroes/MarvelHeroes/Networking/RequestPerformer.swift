//
//  RequestPerformer.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import CommonCrypto

class RequestPerformer {
    
    private let baseURL: String = "https://gateway.marvel.com"
    private let charactersPath: String = "/v1/public/characters"
    
    private let publicKey = "f1a9b1c3346ee87c71f463a81ffbebfc"
    private let privateKey = "b45d57cc362cc6ed4fd9f45cf2d7754d0636c332"
    
    func fetchCharacters(offset: Int, search: String? = nil, successHandler: @escaping (([Character]) -> Void)) {
        var urlComp = URLComponents(string: baseURL + charactersPath)!
        
        let timeStamp = String(Date().timeIntervalSince1970)
        var params = ["apikey":publicKey, "ts":timeStamp, "hash": md5Hash(timeStamp: timeStamp, privateKey: privateKey, publicKey: publicKey), "limit":"20", "offset":"\(offset)"]
        
        if let searchTerm = search {
            params["name"] = searchTerm
        }
        
        var items = [URLQueryItem]()
        for (key,value) in params {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        urlComp.queryItems = items
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else { return }
            
            var serializedJSONResponse: Any
            do {
                serializedJSONResponse = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                return
            }
            
            guard let serializedJSONArray = serializedJSONResponse as? [String:Any],
                let dataJSON = serializedJSONArray["data"] as? [String:Any],
                let characterJSON = dataJSON["results"] as? [[String:Any]]
                else { return }
            
            let jsonParser = JSONParser()
            let characterList = jsonParser.characterListFrom(json: characterJSON)
            
            successHandler(characterList)
        }
        task.resume()
    }
    
    func md5Hash(timeStamp: String, privateKey: String, publicKey: String) -> String {
        let string = timeStamp + privateKey + publicKey
        
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        let hashHexString = digestData.map { String(format: "%02hhx", $0) }.joined()
        
        return hashHexString
    }
}
