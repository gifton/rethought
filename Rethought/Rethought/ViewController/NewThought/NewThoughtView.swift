//
//  QuickAddView.swift
//  rethought
//
//  Created by Dev on 12/14/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
class NewThoughtView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "384CBC")
    }
    convenience init(frame: CGRect, delegate: HomeViewControllerDelegate, icon: ThoughtIcon) {
        self.init(frame: frame)
        self.homeDelegate = delegate
        self.currentThoughtIcon = icon
        setup()
    }
    enum NewThoughtViewState {
        case open
        case closed
    }
    
    public var state: NewThoughtViewState = .closed
    public var homeDelegate: HomeViewControllerDelegate?
    public var currentThoughtIcon: ThoughtIcon?
    
    public var thoughtButton = UIButton(frame: CGRect(x: 55, y: 25, width: ViewSize.SCREEN_WIDTH - 75, height: 30))
    public var recentThought = UIButton(frame: CGRect(x: 15, y: 25, width: 30, height: 30))
    var newThoughtTitleTextView = ReTextView(frame: CGRect(x: 15, y: 70, width: ViewSize.SCREEN_WIDTH - 30, height: 30))
    var newThoughtDescriptionView = ReTextView(frame: CGRect(x: 15, y: 110, width: ViewSize.SCREEN_WIDTH - 30, height: 300))
    var newThoughtPictureButton = UIButton(frame: CGRect(x: 15, y: 440, width: 160, height: 60))
    var newThoughtLinkButton = UIButton(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 175, y: 440, width: 160, height: 60))
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setRecentThought() {
        self.recentThought.setTitle(self.currentThoughtIcon?.icon ?? ThoughtIcon(nil).icon, for: .normal)
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
    
    func styleOpenView() {
        newThoughtTitleTextView.backgroundColor = .white
        newThoughtTitleTextView.font = .reTitle(ofSize: fontSize.small.rawValue)
        newThoughtTitleTextView.layer.cornerRadius = 4
        newThoughtTitleTextView.placeholder = "Description, 10 words or less"
        
        newThoughtDescriptionView.backgroundColor = .white
        newThoughtDescriptionView.font = .reBody(ofSize: fontSize.medium.rawValue)
        newThoughtDescriptionView.layer.cornerRadius = 4
        newThoughtDescriptionView.placeholder = "Okay, start from the beginig..."
        
        let attribute = [ NSAttributedString.Key.font: UIFont.reBodyLight(ofSize: 16),  NSAttributedString.Key.foregroundColor: UIColor.white]
        let linkString = NSAttributedString(string: "link", attributes: attribute as [NSAttributedString.Key : Any])
        newThoughtLinkButton.setAttributedTitle(linkString, for: .normal)
        newThoughtLinkButton.backgroundColor = UIColor(hex: "7E86B7")
        newThoughtLinkButton.layer.cornerRadius = 5
        
        let picString = NSAttributedString(string: "picture", attributes: attribute as [NSAttributedString.Key : Any])
        newThoughtPictureButton.backgroundColor = UIColor(hex: "F96969")
        newThoughtPictureButton.layer.cornerRadius = 5
        newThoughtPictureButton.setAttributedTitle(picString, for: .normal)
        
        
    }
    
    
    func setup() {
        switch self.state {
        case .open:
            addSubview(newThoughtTitleTextView)
            addSubview(newThoughtDescriptionView)
            addSubview(newThoughtLinkButton)
            addSubview(newThoughtPictureButton)
            
            styleOpenView()
        default:
            let views = [newThoughtTitleTextView, newThoughtDescriptionView, newThoughtPictureButton, newThoughtLinkButton]
            for view in views {
                if view.isDescendant(of: self) {
                    view.removeFromSuperview()
                } else {
                    continue
                }
            }
            
            addSubview(thoughtButton)
            addSubview(recentThought)
            
            thoughtButton.addTarget(self, action: #selector(userDidStartNewThought(_:)), for: .touchUpInside)
            recentThought.addTarget(self, action: #selector(userDidTapIcon(_:)), for: .touchUpInside)
            styleClosedView()
            
        }
    }
    
}

extension NewThoughtView {
    public func isOpen() {
        backgroundColor = UIColor(hex: "E7E7E8")
        self.thoughtButton.backgroundColor = UIColor(hex: "51DF9F")
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 16)]
        let openStr = NSAttributedString(string: "Save Thought", attributes: attribute as [NSAttributedString.Key : Any])
        self.thoughtButton.setAttributedTitle(openStr, for: .normal)
        state = .open
        setup()
    }
    
    public func isClosed() {
        backgroundColor = UIColor(hex: "384CBC")
        self.thoughtButton.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        let attribute = [ NSAttributedString.Key.font: UIFont(name: "Lato-Light", size: 14)]
        let closedStr = NSAttributedString(string: "Save THought", attributes: attribute as [NSAttributedString.Key : Any])
        self.thoughtButton.setAttributedTitle(closedStr, for: .normal)
        state = .closed
        setup()
    }
    
    @objc
    func userDidStartNewThought(_ sender: UIButton) {
        if state == .closed {
            state = .open
            homeDelegate?.userTappedNewThought(closure: {
                self.isOpen()
            })
        }else {
            state = .closed
            homeDelegate?.userTappedNewThought(closure: {
               self.isClosed()
            })
        }
        
    }
    @objc
    func userDidTapIcon(_ sender: Any) {
        print ("user tapped icon in child view")
        guard let delegate = homeDelegate else { return }
        delegate.userDidTapQuickAddIcon()
    }
}
