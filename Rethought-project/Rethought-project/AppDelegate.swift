//
//  AppDelegate.swift
//  Rethought-project
//
//  Created by Dev on 3/9/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav: UINavigationController?
    var persistentContainer: NSPersistentContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createThoughtContainer { (container) in
            
            self.persistentContainer = container
            
            if self.isUsersFirstTime() {
                self.addThoughts()
            }
            
            self.window = UIWindow(frame: Device.size.frame)
            self.window?.makeKeyAndVisible()
            
            let rootVC = RootController()
            rootVC.moc = container.viewContext
            
            self.nav = UINavigationController(rootViewController: rootVC)
            self.nav?.isNavigationBarHidden = true
            
            self.window?.rootViewController = self.nav!
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

    func isUsersFirstTime() -> Bool {
        //defaults handle thought andentry ID validation
        //check to see if a thought has ever been made, if so, defaults will have updated to a non-zero num
        //otherwise set defaults to 1
        let defaults = UserDefaults.standard
        
        if defaults.integer(forKey: UserDefaults.Keys.thoughtID) == 0 && defaults.integer(forKey: UserDefaults.Keys.entryID) == 0 {
            defaults.set(1, forKey: UserDefaults.Keys.thoughtID)
            defaults.set(1, forKey: UserDefaults.Keys.entryID)
            return true
        }
        
        return false
    }
    
    func addThoughts() {
        let replicator = Replicator(with: self.persistentContainer.viewContext)
        replicator.createThoughts()
    }
}
