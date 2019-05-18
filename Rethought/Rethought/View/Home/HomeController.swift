//
//  HomeController.swift
//  Rethought
//
//  Created by Dev on 5/14/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setView()
    }
    var homeHead: HomeHead?
    var tv: HomeTable?
    
    func setView() {
        tv = HomeTable(frame: CGRect(x: 0, y: 500, width: Device.size.width, height: Device.size.height - 500))
        tv?.animator = self
        
        homeHead = HomeHead(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: 500))
        view.addSubview(homeHead!)
        view.addSubview(tv!)
    }
    
    
}
extension HomeController: Animator {
    func didUpdate() {
        let progress = tv?.animationProgress ?? 1
        homeHead?.update(toAnimationProgress: progress)
    }
    
    
}
