//
//  AppDelegate.swift
//  rethought
//
//  Created by Dev on 12/7/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: ViewSize.FRAME)
        window?.makeKeyAndVisible()
        
        let rootVC = DashboardController(withContext: PersistanceService.context)
        let nav = UINavigationController(rootViewController: rootVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        
        //defaults handle thoughtID validation
        //check to see if a thought has ever been made, if so, defaults will have updated to a non-zero num
        //otherwise set defaults to 1
        let defaults = UserDefaults.standard
        if defaults.integer(forKey: UserDefaults.Keys.thoughtID) == 0 && defaults.integer(forKey: UserDefaults.Keys.entryID) == 0 {
            print("user has not set first thought")
            defaults.set(1, forKey: UserDefaults.Keys.thoughtID)
            defaults.set(1, forKey: UserDefaults.Keys.entryID)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) {
        PersistanceService.saveContext()
    }

}

