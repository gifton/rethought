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
    var persistentContainer: NSPersistentContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        createThoughtContainer { (container) in
            self.window = UIWindow(frame: ViewSize.FRAME)
            self.window?.makeKeyAndVisible()
            
            self.persistentContainer = container
            self.isUsersFirstTime()
            
            let rootModel = RootViewModel(with: container.viewContext)
            let rootVC = MasterTabbar(model: rootModel)
            
            let nav = UINavigationController(rootViewController: rootVC)
            self.setNav(nav: nav)
            self.window?.rootViewController = nav
        }
        
        return true
    }
    
    func setNav(nav: UINavigationController) {
        
        UINavigationBar.appearance().shadowImage = UIImage(color: .white)
        nav.hidesBarsOnTap = false
        nav.hidesBarsOnSwipe = false
        
        
        setReNavbar(nav: nav.navigationBar)
    }
    
    func setReNavbar(nav: UINavigationBar) {
        nav.barTintColor = .white
        let firstFrame = CGRect(x: 10, y: 0, width: nav.frame.width/2, height: nav.frame.height)
        let secondFrame = CGRect(x: 10, y: 30, width: nav.frame.width/2, height: nav.frame.height)
        
        let firstLabel = UILabel(frame: firstFrame)
        firstLabel.text = "Rethought"
        firstLabel.textAlignment = .left
        let font = firstLabel.font
        let cfont = font?.fontName.components(separatedBy: "-").first
        firstLabel.font = UIFont(name: "\(cfont!)-heavy", size: 35)
        
        let secondLabel = UILabel(frame: secondFrame)
        secondLabel.text = "March 24th, 2019"
        secondLabel.textColor = UIColor(hex: "868686")
        secondLabel.font = .boldSystemFont(ofSize: 14)
        secondLabel.textAlignment = .left
        
        firstLabel.clipsToBounds = true
        secondLabel.clipsToBounds = true
        
        nav.addSubview(firstLabel)
        nav.addSubview(secondLabel)
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try persistentContainer.viewContext.save()
        } catch let err {
            print(err)
        }
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
        let replicator = Replicator(with: self.persistentContainer.viewContext)
        replicator.createThoughts()
    }

}

extension AppDelegate: UINavigationBarDelegate {
    
}
