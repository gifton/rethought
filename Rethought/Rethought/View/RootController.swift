//
//  ViewController.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import UIKit

class ViewController: AnimatedTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        
        vc1.view.backgroundColor = Device.colors.blue
        vc2.view.backgroundColor = Device.colors.green
        vc3.view = ThoughtBuilderView()
        
        vc1.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home_light"), selectedImage: #imageLiteral(resourceName: "home_dark"))
        vc2.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "Search_dark"), selectedImage: #imageLiteral(resourceName: "Search_dark"))
        vc3.tabBarItem = UITabBarItem(title: "THiNK", image: #imageLiteral(resourceName: "cloud_light"), selectedImage: #imageLiteral(resourceName: "cloud_dark"))
        
        let vcs = [vc1, vc2, vc3]
        
        viewControllers = vcs
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
    }
    
}
