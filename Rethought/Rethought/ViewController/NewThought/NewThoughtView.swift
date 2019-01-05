//
//  QuickAddView.swift
//  rethought
//
//  Created by Dev on 12/14/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
class NewThoughtView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("this is the frame from our init \(self.frame)")
//        self.setGradientBackground(colorTop: UIColor(hex: "6271FC"), colorBottom: UIColor(hex: "384CBC"))
        self.backgroundColor = UIColor(hex: "384CBC")
    }
    convenience init(frame: CGRect, delegate: HomeViewControllerDelegate, icon: ThoughtIcon) {
        self.init(frame: frame)
        self.delegate = delegate
        self.currentThoughtIcon = icon
        setupClosedView()
    }
    enum NewThoughtViewState {
        case open
        case closed
    }
    public var state: NewThoughtViewState = .closed
    public var delegate: HomeViewControllerDelegate?
    public var currentThoughtIcon: ThoughtIcon?
    public var thoughtButton = UIButton(frame: CGRect(x: 50, y: 25, width: ViewSize.SCREEN_WIDTH - 70, height: 30))
    public var recentThought = UIButton(frame: CGRect(x: 10, y: 25, width: 30, height: 30))
    let newThoughtTitleTextView = UITextView(frame: CGRect(x: 10, y: 100, width: ViewSize.SCREEN_WIDTH - 20, height: 300))
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewThoughtView: UITextViewDelegate {
    func styleClosedView() {
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Light", size: 14)]
        let myAttrString = NSAttributedString(string: "Whats on your mind?", attributes: attribute as [NSAttributedString.Key : Any])
        thoughtButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        thoughtButton.layer.cornerRadius = 5
        thoughtButton.setAttributedTitle(myAttrString, for: .normal)
        
        recentThought.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        recentThought.layer.cornerRadius = 4
        
    }
    fileprivate func setupClosedView() {
        
    }
    
    func setRecentThought() {
        self.recentThought.setTitle(self.currentThoughtIcon?.icon ?? ThoughtIcon(nil).icon, for: .normal)
    }
    
    func setup() {
        switch self.state {
        case .open:
            addSubview(newThoughtTitleTextView)
            
            styleOpenView()
        default:
            if 
            addSubview(thoughtButton)
            addSubview(recentThought)
            
            thoughtButton.addTarget(self, action: #selector(userDidStartNewThought(_:)), for: .touchUpInside)
            recentThought.addTarget(self, action: #selector(userDidTapIcon(_:)), for: .touchUpInside)
            styleClosedView()
        }
    }
    
    @objc
    func userDidStartNewThought(_ sender: UIButton) {
        if thoughtButton.backgroundColor == .white {
            thoughtButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            thoughtButton.setTitleColor(.black, for: .normal)
        } else {
            thoughtButton.backgroundColor = .white
            thoughtButton.setTitleColor(.white, for: .normal)
        }
        print("oh fuck")
        delegate?.userBeganQuickAdd()
    }
    @objc
    func userDidTapIcon(_ sender: Any) {
        print ("user tapped icon in child view")
        guard let delegate = delegate else { return }
        print (delegate)
        delegate.userDidTapQuickAddIcon()
    }
    
    func styleOpenView() {
        newThoughtTitleTextView.backgroundColor = .white
        newThoughtTitleTextView.font = .reBody(ofSize: fontSize.small.rawValue)
        newThoughtTitleTextView.layer.cornerRadius = 4
        
        thoughtButton.center.y += 35
        recentThought.center.y += 35

    }
    
    func setupOpenView() {
        
        
    }
    
}

extension NewThoughtView {
    public func isOpen() {
        print("you made it here hoss")
        self.backgroundColor = UIColor(hex: "E7E7E8")
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Light", size: 14)]
        let myAttrString = NSAttributedString(string: "New Thought", attributes: attribute as [NSAttributedString.Key : Any])
        thoughtButton.setAttributedTitle(myAttrString, for: .normal)
        thoughtButton.backgroundColor = .white
        
        setupOpenView()
    }
    
    public func isClosed() {
        setupClosedView()
    }
}
