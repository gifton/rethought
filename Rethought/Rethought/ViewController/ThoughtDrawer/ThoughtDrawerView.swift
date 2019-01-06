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
    public var delegate: NewThoughtDelegate?
    
    //main objects
    public var iconLabel                  = UILabel()
    private var newThoughtIntro           = UILabel()
    private var timeSinceLastThoughtLabel = UILabel()
    private var activityButton            = UIButton()
    
    //objects later init'd
    private var newThoughtTitleTextView: ReTextView?
    private var newThoughtIcon         : UILabel?
    private var startThoughtTitleButton: UIButton?
    private var cancelNewThought: UIButton?
}

extension ThoughtDrawerView {
    func layout() {
        switch state {
        case .beginThought:
            newThoughtIcon          = UILabel(frame: CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 75, width: 45, height: 45))
            startThoughtTitleButton = UIButton(frame: CGRect(x: 130, y: 80, width: 175, height: 35))
            cancelNewThought        = UIButton(frame: CGRect(x: 15, y: 80, width: 100, height: 35))
            
            newThoughtTitleTextView?.removeFromSuperview()
            
            addSubview(newThoughtIcon!)
            addSubview(startThoughtTitleButton!)
            addSubview(cancelNewThought!)
            
            activityButton.removeTarget(self, action: #selector(userTappedToMakeNewThought(_:)), for: .touchUpInside)
            activityButton.addTarget(self, action: #selector(beginWriting(_:)), for: .touchUpInside)
        case .isWriting:
            print("it is now riting")
            newThoughtTitleTextView = ReTextView(frame: CGRect(x: 15, y: 80, width: ViewSize.SCREEN_WIDTH - 30, height: 35))
            
            startThoughtTitleButton?.removeFromSuperview()
            cancelNewThought?.removeFromSuperview()
            newThoughtIcon?.removeFromSuperview()
            addSubview(newThoughtTitleTextView!)
            
            activityButton.removeTarget(self, action: #selector(beginWriting(_:)), for: .touchUpInside)
            activityButton.addTarget(self, action: #selector(userTappedToMakeNewThought(_:)), for: .touchUpInside)
            
        case .completeThought:
            newThoughtTitleTextView?.removeFromSuperview()
            
        default:
            print("fuck")
        }
        
    }
    
    func style() {
        switch state {
        case .beginThought:
            newThoughtIcon?.text               = "🔀"
            newThoughtIcon?.font               = .reBody(ofSize: 24)
            newThoughtIcon?.textAlignment      = .center
            newThoughtIcon?.backgroundColor    = UIColor(hex: "47484D")
            newThoughtIcon?.layer.opacity      = 0.4
            newThoughtIcon?.layer.cornerRadius = 6
            newThoughtIcon?.layer.borderWidth  = 5
            newThoughtIcon?.layer.borderColor  = UIColor.white.cgColor
            
            let att                                     = [ NSAttributedString.Key.font: UIFont.reBody(ofSize: 15),  NSAttributedString.Key.foregroundColor: UIColor.white]
            let str                                     = NSAttributedString(string: "Write a brief description", attributes: att as [NSAttributedString.Key : Any])
            startThoughtTitleButton?.setAttributedTitle(str, for: .normal)
            startThoughtTitleButton?.backgroundColor    = UIColor(hex: "6271fc")
            startThoughtTitleButton?.layer.cornerRadius = 5
            
            let cancelStr                        = NSAttributedString(string: "Cancel", attributes: att as [NSAttributedString.Key : Any])
            cancelNewThought?.backgroundColor    = .mainRed
            cancelNewThought?.layer.cornerRadius = 5
            cancelNewThought?.setAttributedTitle(cancelStr, for: .normal)
            
            
            cancelNewThought?.addTarget(self, action: #selector(cancelThought(_:)), for: .touchUpInside)
            startThoughtTitleButton?.addTarget(self, action: #selector(beginWriting(_:)), for: .touchUpInside)
        case .isWriting:
        
            newThoughtTitleTextView?.placeholder = "Start Here"
            newThoughtTitleTextView?.font = .reBody(ofSize: 12)
            newThoughtTitleTextView?.backgroundColor = UIColor(hex: "384CBC")
        default:
            print("welp")
        }
        
    }
    func buildClosed() {
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
        activityButton.frame            = CGRect(x: ViewSize.SCREEN_WIDTH - 60, y: 25, width: 30, height: 30)
        
        newThoughtIntro.font           = .reBody(ofSize: fontSize.small.rawValue)
        iconLabel.font                 = .reBody(ofSize: fontSize.xXXLarge.rawValue)
        timeSinceLastThoughtLabel.font = .reBodyLight(ofSize: fontSize.small.rawValue)
        
        timeSinceLastThoughtLabel.textColor = .white
        
        activityButton.setImage(#imageLiteral(resourceName: "arrow-up"), for: .normal)
        activityButton.removeTarget(nil, action: nil, for: .allEvents)
        activityButton.addTarget(self, action: #selector(userTappedToMakeNewThought(_:)), for: .touchUpInside)
        //activityButton.imageView?.sizeToFit()
        
        giveLightBackground(to: [iconLabel, newThoughtIntro], cornerRadius: 5)
        
        iconLabel.text = "💭"
        iconLabel.textAlignment = .center
        
        newThoughtIntro.text = "Whats on your mind?"
        newThoughtIntro.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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
}

