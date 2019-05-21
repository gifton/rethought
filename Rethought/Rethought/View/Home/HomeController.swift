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
    lazy var tableButtonMoreView: UIView = UIView()
    
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
    
    func show(optionsFor entry: Entry) {
        
        tabBarController?.tabBar.isHidden = true
        let optionView = ShowOptionsView(frame: CGRect(x: 0, y: Device.size.height + 225, width: Device.size.width, height: 225), options: [.delete, .toEntry, .toThought])
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - optionView.height))
        newView.blurBackground(type: .dark, cornerRadius: 0)
        newView.layer.opacity = 0
        view.addSubview(newView)
        
        self.view.addSubview(optionView)
        let end = {
            optionView.removeFromSuperview()
            newView.removeFromSuperview()
            self.tabBarController?.tabBar.isHidden = false
        }
        
        newView.addTapGestureRecognizer { end() }
        optionView.cancelButton.addTapGestureRecognizer { end() }
        

        UIView.animate(withDuration: 0.25, animations: {
            optionView.frame.origin.y -= 225 * 2
            newView.layer.opacity = 0.55
        }) { (true) in
            print("added optionView")
        }
        
    }
}
