//
//  AppDelegate.swift
//  apple swiftUI tutorial
//
//  Created by David Gaz on 14.05.2020.
//  Copyright © 2020 David Gaz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        updateDraftStorage()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
    // open url metod dont run without this
        print("applicationDidFinishLaunching")
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // handle the file here
print("fileget")
        print(url)
        
        return true // or false based on whether you were successful or not
    }

    func updateDraftStorage() -> Void {
        var draftsNames = UserDefaults.standard.stringArray(forKey: "draftsNames") ?? ["empty"]
        draftsNames = draftsNames.filter {$0 != "empty" }
        UserDefaults.standard.set(draftsNames, forKey: "draftsNames")
    }

}

