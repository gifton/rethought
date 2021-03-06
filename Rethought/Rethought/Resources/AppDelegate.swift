//
//  AppDelegate.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var moc: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // create core data container to launch application in
        createThoughtContainer { (container) in
            self.moc = container.viewContext
            // check users first time
            self.isUsersFirstTime()
            
            //set window
            self.window = UIWindow(frame: Device.size.frame)
            self.window?.makeKeyAndVisible()
            IQKeyboardManager.shared.enable = true
            
            let rootVC = ViewController(model: container.viewContext)
            let nav = UINavigationController(rootViewController: rootVC)
            nav.isNavigationBarHidden = true
            
            self.window?.rootViewController = nav
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func isUsersFirstTime() {
        //defaults handle thought andentry ID validation
        //check to see if a thought has ever been made, if so, defaults will have updated to a non-zero num
        //otherwise set defaults to 1
        let defaults = UserDefaults.standard
        if defaults.integer(forKey: UserDefaults.Keys.thoughtID) == 0 && defaults.integer(forKey: UserDefaults.Keys.entryID) == 0 {
            print("user has not set first thought")
            defaults.set(1, forKey: UserDefaults.Keys.thoughtID)
            defaults.set(1, forKey: UserDefaults.Keys.entryID)
            
            addThoughts()
            
        }
    }
    
    func addThoughts() {
        guard let moc = moc else { return }
        print("adding thoughts from delegate")
        let replicator = Replicator(withMoc: moc)
        replicator.createThoughts()
    }
}

