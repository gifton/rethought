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
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) {
        PersistanceService.saveContext()
    }
    
//    fileprivate func handleRunCount() {
//        let defaults = UserDefaults.standard
//
//        //Store a finger to runCount, not that complex, nothing to worry about.
//        var runCount: Int = defaults.integer(forKey: runCountNamespace)
//
//        if(runCount == 0) {
//            print("First time app run, therefore importing event data from local source...")
//            localReplicator.fetchData()
//        }
//
//        runCount += 1
//        defaults.set(runCount, forKey:runCountNamespace)
//        print("current runCount: \(runCount)")
//    }

}

