//
//  AppDelegate.swift
//  SeSACReminders
//
//  Created by cho on 2/14/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = Realm.Configuration(schemaVersion: 2) { migration, oldSchemaVersion in
            
            //1: TodoTable에 flag컬럼 추가
            if oldSchemaVersion < 1 {
                print("schemaVersion : 0 -> 1, TodoTable에 flag 컬럼 추가")
            }
            
            //2: TodoTable에 title -> name으로 이름수정
            if oldSchemaVersion < 2 {
                migration.renameProperty(onType: TodoTable.className(), from: "title", to: "name")
            }
        }
        Realm.Configuration.defaultConfiguration = configuration
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


}

