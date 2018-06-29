//
//  AppDelegate.swift
//  Foursquare
//
//  Created by Eduard Ani on 23/04/2018.
//  Copyright © 2018 Ani Eduard. All rights reserved.
//

import UIKit
import ReSwift

let injector: Injector = Injector()
let store = Store<FetchedPlacesState>(reducer: (injector.resolve(AppReducer.self)!).reduce, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let rootViewController = injector.resolve(PlacesViewController.self)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        return true
    }
}
