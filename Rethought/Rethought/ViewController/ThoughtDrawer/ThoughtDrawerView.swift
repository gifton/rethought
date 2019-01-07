//
//  ThoughtDrawerView.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import ISEmojiView

class ThoughtDrawerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hex: "384CBC")
        self.addBorders(edges: [.top], color: UIColor.white, thickness: 5)
        self.addLogoShadow()
        buildClosed()
    }
    
    convenience init(frame: CGRect, lastThought: String, delegate: NewThoughtDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
        self.timeSinceLastThoughtLabel.text = lastThought
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //all public vars
    public var state: thoughtDrawerHeight = .closed
    public var writingState: ThoughtDrawerWritingType = .title
    public var delegate: NewThoughtDelegate?
    
    //main objects
    public var iconLabel                  = UILabel()
    private var newThoughtIntro           = UILabel()
    private var timeSinceLastThoughtLabel = UILabel()
    private var activityButton            = UIButton()
    
    //objects later init'd
    private var newThoughtTitleTextView: ReTextView?
    private var newThoughtIcon         : UIButton?
    private var startThoughtTitleButton: UIButton?
    private var cancelNewThought       : UIButton?
    private var emojiView              : EmojiView?
    private var newThoughtEmojiDisplay : EmojiDisplay?
}

extension ThoughtDrawerView {
    func layout() {
        switch state {
        case .beginThought:
            newThoughtIcon          = UIButton(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 75, width: 45, height: 45))
            startThoughtTitleButton = UIButton(frame: CGRect(x: 130, y: 80, width: 175, height: 35))
            cancelNewThought        = UIButton(frame: CGRect(x: 15, y: 80, width: 100, height: 35))
            
            addSubview(newThoughtIcon!)
            addSubview(startThoughtTitleButton!)
            addSubview(cancelNewThought!)
            
            activityButton.removeTarget(self, action: #selector(userTappedToMakeNewThought(_:)), for: .touchUpInside)
            activityButton.addTarget(self, action: #selector(beginWriting(_:)), for: .touchUpInside)
            newThoughtIcon?.addTarget(self, action: #selector(addIcon(_:)), for: .touchUpInside)
        case .isWriting:
            if self.writingState == .title {
                newThoughtTitleTextView = ReTextView(frame: CGRect(x: 15, y: 80, width: ViewSize.SCREEN_WIDTH - 30, height: 35))
                
                addSubview(newThoughtTitleTextView!)
                
                activityButton.removeTarget(self, action: #selector(beginWriting(_:)), for: .touchUpInside)
                activityButton.addTarget(self, action: #selector(userTappedToMakeNewThought(_:)), for: .touchUpInside)
            } else {
                let keyboardSettings = KeyboardSettings(bottomType: .pageControl)
                emojiView = EmojiView(keyboardSettings: keyboardSettings)
                emojiView!.delegate = self
                
                newThoughtEmojiDisplay = EmojiDisplay(frame: CGRect(x: ViewSize.SCREEN_WIDTH - (((ViewSize.SCREEN_WIDTH - 125) / 2) + 125), y: 130, width: 125, height: 125), emoji: ThoughtIcon("🤸🏼‍♂️"))
                emojiView?.frame = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 450, width: ViewSize.SCREEN_WIDTH, height: 450)
                
                newThoughtEmojiDisplay!.inputView = emojiView
                
                addSubview(newThoughtEmojiDisplay!)
                addSubview(emojiView!)
            }
            
        case .completeThought:
            newThoughtTitleTextView?.removeFromSuperview()
            
        default:
            print("fuck")
        }
    }
    
    func style() {
        switch state {
        case .beginThought:
            let attSmall                        = [ NSAttributedString.Key.font: UIFont.reBody(ofSize: fontSize.small.rawValue)]
            let attLarge                        = [ NSAttributedString.Key.font: UIFont.reBody(ofSize: fontSize.xXXLarge.rawValue)]
            let str1                            = NSAttributedString(string: "🔀", attributes: attLarge as [NSAttributedString.Key : Any])
            let str2                            = NSAttributedString(string: "Write a brief description", attributes: attSmall as [NSAttributedString.Key : Any])
            newThoughtIcon?.setAttributedTitle(str1, for: .normal)
            newThoughtIcon?.backgroundColor     = .white
            newThoughtIcon?.layer.cornerRadius  = 6
            newThoughtIcon?.layer.masksToBounds = true
            
            
            startThoughtTitleButton?.setAttributedTitle(str2, for: .normal)
            startThoughtTitleButton?.backgroundColor    = UIColor(hex: "6271fc")
            startThoughtTitleButton?.layer.cornerRadius = 5
            
            let cancelStr                        = NSAttributedString(string: "Cancel", attributes: attSmall as [NSAttributedString.Key : Any])
            cancelNewThought?.backgroundColor    = .mainRed
            cancelNewThought?.layer.cornerRadius = 5
            cancelNewThought?.setAttributedTitle(cancelStr, for: .normal)
            
            
            cancelNewThought?.addTarget(self, action: #selector(cancelThought(_:)), for: .touchUpInside)
            startThoughtTitleButton?.addTarget(self, action: #selector(beginWriting(_:)), for: .touchUpInside)
        case .isWriting:
        
            newThoughtTitleTextView?.placeholder = "Start Hebre"
            newThoughtTitleTextView?.font = .reBody(ofSize: 12)
            newThoughtTitleTextView?.backgroundColor = UIColor(hex: "384CBC")
        default:
            print("welp")
        }
        
    }
    fileprivate func buildClosed() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        addSubview(newThoughtIntro)
        addSubview(iconLabel)
        addSubview(timeSinceLastThoughtLabel)
        addSubview(activityButton)
        
        newThoughtIntro.frame           = CGRect(x: 75, y: 25, width: 150, height: 30)
        iconLabel.frame                 = CGRect(x: 15, y: 25, width: 50, height: 50)
        timeSinceLastThoughtLabel.frame = CGRect(x: 75, y: 60, width: 200, height: 14)
        activityButton.frame            = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 30, width: 30, height: 30)
        
        newThoughtIntro.font           = .reBody(ofSize: 12)
        iconLabel.font                 = .reBody(ofSize: 24)
        timeSinceLastThoughtLabel.font = .reBodyLight(ofSize: 12)
        
        timeSinceLastThoughtLabel.textColor = .white
        
        activityButton.setImage(#imageLiteral(resourceName: "arrow-up"), for: .normal)
        activityButton.removeTarget(nil, action: nil, for: .allEvents)
        activityButton.addTarget(self, action: #selector(userTappedToMakeNewThought(_:)), for: .touchUpInside)
        
        giveLightBackground(to: [iconLabel, newThoughtIntro], cornerRadius: 5)
        
        iconLabel.text = "💭"
        iconLabel.textAlignment = .center
        
        newThoughtIntro.text = "Whats on your mind?"
        newThoughtIntro.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    private func clear() {
        switch state {
        case .beginThought:
            if self.writingState == .title {
                newThoughtTitleTextView?.removeFromSuperview()
            } else {
                
            }
        case .isWriting:
            if self.writingState == .title {
                startThoughtTitleButton?.removeFromSuperview()
                cancelNewThought?.removeFromSuperview()
                newThoughtIcon?.removeFromSuperview()
            }
        case .completeThought:
            startThoughtTitleButton?.removeFromSuperview()
            
        default:
            print("no clearing needed")
        }
    }
    
}

extension ThoughtDrawerView: EmojiViewDelegate {
    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
       newThoughtEmojiDisplay?.emoji = ThoughtIcon(emoji)
    }
}

extension ThoughtDrawerView {
    @objc
    func userTappedToMakeNewThought(_ sender: Any) {
        if state == .isWriting {
            self.endEditing(true)
            _ = newThoughtTitleTextView?.resignFirstResponder()
        }
        state = .beginThought
        guard var delegate = self.delegate else { return }
        delegate.thoughtState = .beginThought
        if activityButton.image(for: .normal) == UIImage(named: "arrow-down.png") {
            activityButton.setImage(#imageLiteral(resourceName: "arrow-up"), for: .normal)
        }
        clear()
        layout()
        style()
    }
    @objc
    func cancelThought(_ sender: Any) {
        state = .closed
        delegate?.thoughtState = .closed
        buildClosed()
        
    }
    @objc
    func beginWriting(_ sender: UIButton) {
        state = .isWriting
        delegate?.thoughtState = .isWriting
        activityButton.setImage(#imageLiteral(resourceName: "arrow-down"), for: .normal)
        layout()
        style()
    }
    @objc
    func addIcon(_ sender: UIButton) {
        delegate?.thoughtState = .isWriting
        clear()
        layout()
        print("user wants to add Icon")
    }
}

