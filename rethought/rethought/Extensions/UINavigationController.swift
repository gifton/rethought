//
//  UINavigationController.swift
//  rethought
//
//  Created by Dev on 3/2/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import UIKit


extension UINavigationController {
    
    func setReNavbar(title1: String, title2: String) {
        
        let firstFrame = CGRect(x: 10, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
        let secondFrame = CGRect(x: 10, y: 30, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
        
        let firstLabel = UILabel(frame: firstFrame)
        firstLabel.text = title1
        firstLabel.textAlignment = .left
        let font = firstLabel.font
        let cfont = font?.fontName.components(separatedBy: "-").first
        firstLabel.font = UIFont(name: "\(cfont!)-heavy", size: 35)
        
        let secondLabel = UILabel(frame: secondFrame)
        secondLabel.text = title2
        secondLabel.textColor = UIColor(hex: "868686")
        secondLabel.font = .boldSystemFont(ofSize: 14)
        secondLabel.textAlignment = .left
        
        firstLabel.clipsToBounds = true
        secondLabel.clipsToBounds = true
        
        navigationBar.addSubview(firstLabel)
        navigationBar.addSubview(secondLabel)
        
        hidesBarsOnSwipe = false
        let bounds = navigationBar.bounds
        navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 100)
    }
    
    @objc
    func hideBarr(_ sender: Any) {
        print("fuuuuck")
    }
    
    
}

