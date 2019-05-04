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
        let vc1 = HomeVC()
        
        let vc2 = UIViewController()
        let vc3 = ConversationController(withModel: ThoughtBuilderViewModel(withContext: model))
        
        vc1.view.backgroundColor = Device.colors.blue
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

class HomeVC: UIViewController {
    override func viewDidLoad() {
        setView()
    }
    
    func setView() {
        let lbl = UILabel()
        lbl.text = "RE\nTHOUGHT"
        lbl.numberOfLines = 5
        lbl.font = Device.font.title(ofSize: .title)
        lbl.textColor = Device.colors.offWhite
        lbl.frame = CGRect(x: 5, y: 5, width: Device.size.width - 20, height: 600)
        
        view.addSubview(lbl)
    }
}
