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
        view.backgroundColor = .blue
        
        setView()
    }
    var homeHead: HomeHead?
    var tv: HomeTable?
    
    func setView() {
        tv = HomeTable(frame: CGRect(x: 0, y: 400, width: Device.size.width, height: Device.size.height - 400))
        tv?.animator = self
        
        homeHead = HomeHead(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: 390))
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
