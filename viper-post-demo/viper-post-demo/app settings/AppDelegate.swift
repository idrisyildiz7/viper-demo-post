//
//  AppDelegate.swift
//  viper-post-demo
//
//  Created by idris yıldız on 3.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        createUsers()
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
    
    func createUsers()
    {
        Dataholder.shared.users.append(UserModel(id: 1, name: "idris", nickName: "@idris47", photoUrl: "user1"))
        Dataholder.shared.users.append(UserModel(id: 2, name: "Alina", nickName: "@alina", photoUrl: "user2"))
        Dataholder.shared.users.append(UserModel(id: 3, name: "Elif", nickName: "@elifoo35", photoUrl: "user3"))
        Dataholder.shared.currentUser = Dataholder.shared.users[0]
    }

}

