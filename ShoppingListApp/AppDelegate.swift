//
//  AppDelegate.swift
//  ShoppingListApp
//
//  Created by Sebastian Hsu on 23/3/2026.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var itemArray: [Item] = []
    
    
    func getDBPath() -> String {
        let documentsDir = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!
        return documentsDir.appendingPathComponent("ShoppingListDB.db").path
    }
    
    func copyDatabase() {
        let fileManager = FileManager.default
        let dbPath = getDBPath()
        
        guard !fileManager.fileExists(atPath: dbPath) else {
            print("Database already exists at: \(dbPath)")
            return
        }
        
        guard
            let defaultDBPath = Bundle.main.path(
                forResource: "ShoppingListDB",
                ofType: "db"
            )
        else {
            print("Cannot find ShoppingListDB.db in bundle.")
            return
        }
        
        do {
            try fileManager.copyItem(atPath: defaultDBPath, toPath: dbPath)
            print("Database copied to: \(dbPath)")
        } catch {
            print("Failed to copy database: \(error.localizedDescription)")
        }
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
//        let item1 = Item(
//            name: "Full Cream Milk",
//            price: 4.2,
//            category: "Grocery",
//            qty: 1,
//            imageName: "Milk"
//        )
//        let item2 = Item(
//            name: "Sharpie",
//            price: 2.5,
//            category: "Stationery",
//            qty: 3,
//            imageName: "Sharpie"
//        )
//        let item3 = Item(
//            name: "Nike socks",
//            price: 3.5,
//            category: "Clothing",
//            qty: 3,
//            imageName: "Socks"
//        )
//        let item4 = Item(
//            name: "Smoked Salmon",
//            price: 12.5,
//            category: "Grocery",
//            qty: 2,
//            imageName: "Salmon"
//        )
//        let item5 = Item(
//            name: "Croissant ",
//            price: 12.99,
//            category: "Grocery",
//            qty: 1,
//            imageName: "Croissant"
//        )
//
//        itemArray = [item1, item2, item3, item4, item5]
        
        copyDatabase()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
