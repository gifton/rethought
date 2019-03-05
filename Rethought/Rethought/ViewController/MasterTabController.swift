//
//  MasterTabController.swift
//  rethought
//
//  Created by Dev on 3/2/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MasterTabbar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(model: RootViewModel) {
        super.init(nibName: nil, bundle: nil)
        let vc = RootViewController(with: model)
        
        vc.tabBarItem.image = #imageLiteral(resourceName: "Root")
        vc.tabBarItem.selectedImage = #imageLiteral(resourceName: "Root-selected")
        setView(withVcs: [vc]); alignBtns()
        navigationController?.navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(withVcs: [UIViewController]) {
        var vcs = [UIViewController]()
        for vc in withVcs {
            vcs.append(vc)
        }
        let icons = [#imageLiteral(resourceName: "Search"), #imageLiteral(resourceName: "new")]
        
        let iconsSelected = [#imageLiteral(resourceName: "search-selected"), #imageLiteral(resourceName: "new-selected")]
        
        for i in Range(0...1) {
            let vc = UIViewController()
            vc.view.backgroundColor = .random
            vc.tabBarItem.image = icons[i]
            vc.tabBarItem.selectedImage = iconsSelected[i]
            vcs.append(vc)
        }
        
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

