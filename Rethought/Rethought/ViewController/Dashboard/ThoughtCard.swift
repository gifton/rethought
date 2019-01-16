//
//  ThoughtCard.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


class ThoughtCard: UIView {
    var delegate: ThoughtCardDelegate?
    var state: ThoughtCardState
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    override init(frame: CGRect) {
        let innerFrame = CGRect(x: 10, y: ViewSize.SCREEN_HEIGHT * 0.87, width: ViewSize.SCREEN_WIDTH - 20, height: 69)
        self.state = .collapsed
        super.init(frame: innerFrame)
        
        setupCard()
        self.addTapGestureRecognizer {
            if self.state == .collapsed {
                self.delegate?.updateState(state: .cardIsEditing)
                self.state = .cardIsEditing
            }
            else {
                self.delegate?.updateState(state: .collapsed)
                self.state = .collapsed
            }
        }
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        self.addGestureRecognizer(panGestureRecognizer!)
        
    }
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self)
        
        if panGesture.state == .began {
            originalPosition = self.center
            currentPositionTouched = panGesture.location(in: self)
        } else if panGesture.state == .changed {
            self.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: self)
            
            if velocity.y >= 700 {
                UIView.animate(withDuration: 0.05
                    , animations: {
                        self.self.frame.origin = CGPoint(
                            x: self.frame.origin.x,
                            y: self.frame.size.height
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.delegate?.updateState(state: .collapsed)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.self.center = self.originalPosition!
                })
            }
        }
    }
    
    convenience init(frame: CGRect, delegate: ThoughtCardDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //all objects
    //closed
    private var iconLabel                 = UILabel()
    private var newThoughtIntro           = UILabel()
    private var timeSinceLastThoughtLabel = UILabel()
    
}

extension ThoughtCard {
    func setupCard() {
        self.backgroundColor = UIColor(hex: "161616")
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        self.addLogoShadow()
        
        newThoughtIntro.frame           = CGRect(x: 75, y: 10, width: 150, height: 30)
        iconLabel.frame                 = CGRect(x: 15, y: 10, width: 50, height: 50)
        timeSinceLastThoughtLabel.frame = CGRect(x: 75, y: 42.5, width: 200, height: 14)
        
        newThoughtIntro.padding        = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        iconLabel.layer.cornerRadius   = 6
        iconLabel.layer.masksToBounds  = true
        iconLabel.textAlignment        = .center
        newThoughtIntro.giveDarkBackground()
        iconLabel.giveDarkBackground()
        iconLabel.addText(size: 24, font: .body, string: "💭")
        newThoughtIntro.addText(color: .white, size: 12, font: .body, string: "What's on your mind?")
        timeSinceLastThoughtLabel.addText(color: .white, size: 12, font: .bodyLight, string: "Last new thought: 4 days")
        
        addSubview(iconLabel)
        addSubview(newThoughtIntro)
        addSubview(timeSinceLastThoughtLabel)
    }
    
    @objc
    func updateSize(_ sender: Any) {
        delegate?.updateState(state: ThoughtCardState.crdIsDoneEditing)
    }
}
