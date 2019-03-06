//
//  NewThoughtView.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


class NewThoughtView: UIView {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: ViewSize.SCREEN_WIDTH, height: 90))
        
        buildLayout(); styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var thoughtTitle: String {
        get {
            return titleTextView.text
        }
    }
    
    public var thoughtIcon: ThoughtIcon {
        get {
            return iconTextView.emoji
        }
    }
    
    // MARK: private vars
    var connector: ThinkDelegate?
    
    // MARK: private objects
    private let iconTextView = EmojiDisplay(frame: CGRect(x: 20, y: 15, width: 56, height: 56), emoji: ThoughtIcon("💡"))
    private let titleTextView = UITextView(frame: CGRect(x: 91, y: 15, width: ViewSize.SCREEN_WIDTH - 111, height: 70))
    
    private func buildLayout() {
        
        addSubview(iconTextView)
        addSubview(titleTextView)
    }
    
    func styleView() {
        self.backgroundColor = .white
        titleTextView.text = "Add a short description"
        titleTextView.font = .reTitle(ofSize: 16)
        titleTextView.textColor = UIColor(hex: "3D3D46")
        titleTextView.textAlignment = .left
        
        iconTextView.backgroundColor = UIColor(hex: "ECECEC")
    }
    
    func checkForCompletion() {
        
    }
    
    func completedComponents() {
        
    }
}
