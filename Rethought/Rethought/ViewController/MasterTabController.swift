//
//  MasterTabController.swift
//  rethought
//
//  Created by Dev on 3/2/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MasterTabbar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(with moc: NSManagedObjectContext) {
        super.init(nibName: nil, bundle: nil)
        setView(with: moc)
        alignBtns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(with moc: NSManagedObjectContext) {
        var vcs = [UIViewController]()
        
        let icon = #imageLiteral(resourceName: "Search")
        let iconSelected = #imageLiteral(resourceName: "search-selected")
        
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .random
        searchVC.tabBarItem.image = icon
        searchVC.tabBarItem.selectedImage = iconSelected
        
        
        let rootVC = RootViewController(with: RootViewModel(with: moc))
        
        rootVC.tabBarItem.image = #imageLiteral(resourceName: "Root")
        rootVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "Root-selected")
        
        
        let thinkVC = ThinkViewController(model: ThinkViewModel(with: moc))
        thinkVC.tabBarItem.image = #imageLiteral(resourceName: "cloud")
        thinkVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "cloud-selected")
        
        vcs.append(rootVC)
        vcs.append(searchVC)
        vcs.append(thinkVC)
        
        self.viewControllers = vcs
        self.tabBar.isOpaque = false
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor(hex: "51DF9F")
        
    }
    
    func alignBtns() {
        guard let items = tabBar.items else { return }
        var count : Int = 0
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            count += 1
        }
    }
    
    
    
}

