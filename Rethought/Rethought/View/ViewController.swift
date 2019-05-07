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
    private let tabBar: RoundedTabBar
    
    init() {
        tabBar = RoundedTabBar()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aView = UIView()
        aView.layer.cornerRadius = 37.5
        aView.backgroundColor = Device.colors.red
        
        aView.isOpaque = false
        aView.layer.shadowOffset = CGSize(width: 0, height: 8)
        aView.layer.shadowRadius = 8
        aView.layer.shadowOpacity = 0.2
        
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        view.addSubview(aView)
        view.addSubview(tabBar)
        
        
        aView.frame = CGRect(x: 90, y: 100, width: 250, height: 250)
        tabBar.frame = CGRect(x: 90, y: 100, width: 250, height: 250)
    }
}


final class RoundedTabBar: UIView {
    var topRadius: CGFloat = 10 {
        didSet {
            updatePath()
        }
    }
    
    var bottomRadius: CGFloat = 38.5 {
        didSet {
            updatePath()
        }
    }
    
    private var path: UIBezierPath?
    
    init() {
        super.init(frame: .zero)
        
        isOpaque = false
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePath()
    }
    
    override func draw(_ rect: CGRect) {
        guard let path = path,
            let context = UIGraphicsGetCurrentContext() else {
                return
        }
        
        context.clear(rect)
        UIColor.white.setFill()
        path.fill()
    }
    
    private func updatePath() {
        let path = UIBezierPath.continuousRoundedRect(bounds, cornerRadius: (topLeft: bottomRadius, topRight: bottomRadius, bottomLeft: bottomRadius, bottomRight: bottomRadius))
        
        layer.shadowPath = path.cgPath
        
        self.path = path
        setNeedsDisplay()
    }
}
