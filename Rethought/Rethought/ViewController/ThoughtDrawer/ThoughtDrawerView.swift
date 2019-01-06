//
//  ThoughtDrawerView.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDrawerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "384CBC")
    }
    
    convenience init(frame: CGRect, lastThought: String, delegate: NewThoughtDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
        self.timeSinceLastThoughtLabel.text = lastThought
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var state: thoughtDrawerHeight = .closed
    public var delegate: NewThoughtDelegate?
    
    public var iconLabel = UILabel()
    private var newThoughtIntro = UILabel()
    private var timeSinceLastThoughtLabel = UILabel()
    private var activityButton = UIButton()
}

extension ThoughtDrawerView {
    func layout() {
        
    }
    
    func style() {
        
    }
    
    func buildClosed() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        addSubview(newThoughtIntro)
        addSubview(iconLabel)
        addSubview(timeSinceLastThoughtLabel)
        addSubview(activityButton)
        
        newThoughtIntro.frame = CGRect(x: 55, y: 25, width: ViewSize.SCREEN_WIDTH - 75, height: 30)
        iconLabel.frame = CGRect(x: 15, y: 25, width: 30, height: 30)
        timeSinceLastThoughtLabel.frame = CGRect(x: 90, y: 50, width: 200, height: 12)
        activityButton.frame = CGRect(x: ViewSize.SCREEN_WIDTH - 45, y: 25, width: 20, height: 20)
        
        newThoughtIntro.font = .reBody(ofSize: 12)
        iconLabel.font = .reBody(ofSize: 24)
        timeSinceLastThoughtLabel.font = .reBodyLight(ofSize: 10)
        timeSinceLastThoughtLabel.textColor = UIColor(hex: 333333)
        giveLightBackground(to: [iconLabel, newThoughtIntro], cornerRadius: 5)
    }
    
    
}
