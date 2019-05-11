//
//  ViewController.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import UIKit
import CoreData


class ViewController: AnimatedTabBarController {
    
    init(model: NSManagedObjectContext) {
        super.init(nibName: nil, bundle: nil)
        let vc1 = UIViewController()
        vc1.view.backgroundColor = Device.colors.blue
        
        let vc2 = UIViewController()
        let vc3 = ConversationController(withModel: ThoughtBuilderViewModel(withContext: model))
        
        vc2.view.backgroundColor = Device.colors.green
            
        vc1.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home_light"), selectedImage: #imageLiteral(resourceName: "home_dark"))
        vc2.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "Search_dark"), selectedImage: #imageLiteral(resourceName: "Search_dark"))
        vc3.tabBarItem = UITabBarItem(title: "THiNK", image: #imageLiteral(resourceName: "cloud_light"), selectedImage: #imageLiteral(resourceName: "cloud_dark"))
        
        let vcs = [vc1, vc2, vc3]
        
        viewControllers = vcs
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
