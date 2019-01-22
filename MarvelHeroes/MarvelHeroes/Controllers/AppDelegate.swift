//
//  AppDelegate.swift
//  MarvelHeroes
//
//  Created by Alex on 12/15/18.
//  Copyright © 2018 Alex. All rights reserved.
//

import UIKit

var requestPerformer: RequestPerformer?

struct Keys {
    static var favoritesPath: String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentDirectory.appending("/profile.plist")
        return path
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var listController: CharacterListController?
    var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if(!FileManager.default.fileExists(atPath: Keys.favoritesPath)){
            let data: [String:String] = [:]
            let nsData = NSDictionary(dictionary: data)
            nsData.write(toFile: Keys.favoritesPath, atomically: true)
        }
        
        // Setup Window
        let window = UIWindow()
        self.window = window
        
        requestPerformer = RequestPerformer()
        
        // Show joke
        let controller = JokeViewController()
        controller.delegate = self
        
        window.rootViewController = controller
        window.makeKeyAndVisible()

        // start loading the results
        listController = CharacterListController(navigationController: navigationController)
        
        return true
    }
}

extension AppDelegate: JokeViewControllerDelegate {
    func didFinishAnimations() {
        window?.rootViewController?.present(navigationController, animated: false)
    }
}
