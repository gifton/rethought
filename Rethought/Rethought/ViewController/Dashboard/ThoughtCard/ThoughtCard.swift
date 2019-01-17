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
    var isTitleComplete: Bool {
        get {
            print ( self.addTitleTV.isCompleted)
            return self.addTitleTV.isCompleted
        }
    }
    var isIconComplete: Bool {
        get {
            print ( self.addIconTV.isCompleted)
            return self.addIconTV.isCompleted
        }
    }
    var entries: [Entry] = []
    
    override init(frame: CGRect) {
        let innerFrame = CGRect(x: 10, y: ViewSize.SCREEN_HEIGHT * 0.87, width: ViewSize.SCREEN_WIDTH - 20, height: 69)
        self.state = .collapsed
        super.init(frame: innerFrame)
        
        self.addLogoShadow()
        self.isUserInteractionEnabled = true
        setupCard()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        self.addGestureRecognizer(panGestureRecognizer!)
        
    }
    
    convenience init(delegate: ThoughtCardDelegate) {
        self.init(frame: .zero)
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
    // optional views
    private var cancelButton = UIButton()
    private var addTitleTV   = ReTextView()
    private var addIconTV    = EmojiDisplay()
    private var doneButton   = newEntryButton()
    private let micBtn       = newEntryButton()
    private let noteBtn      = newEntryButton()
    private let linkBtn      = newEntryButton()
    private let cameraBtn    = newEntryButton()
    private let errorLabel   = UILabel()
}

extension ThoughtCard {
    func setupCard() {
        for view in subviews{
            animateOut(view)
        }
        self.backgroundColor = .darkBackground
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
        
        animateIn(iconLabel)
        animateIn(newThoughtIntro)
        animateIn(timeSinceLastThoughtLabel)
        
        //style
        cancelButton.addAttText(color: .black, size: 12, font: .body, string: "cancel")
        cancelButton.backgroundColor = UIColor(hex: "909090")
        cancelButton.layer.cornerRadius = 3
        addTitleTV.color = .white
        addTitleTV.size = 14
        addTitleTV.placeholder = "Type a brief description"
        addTitleTV.backgroundColor = .black
        addTitleTV.layer.cornerRadius = 10
        addTitleTV.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        addIconTV.backgroundColor = .black
        doneButton.backgroundColor = UIColor(hex: "51DF9F")
        doneButton.layer.cornerRadius = 10
        doneButton.addAttText(color: .white, size: 16, font: .title, string: "Done")
        errorLabel.attributedText = errorLabel.addAttributedText(color: .white, size: 14, font: .bodyLight, string: "please add a title and icon")
        errorLabel.textAlignment = .center
        errorLabel.layer.opacity = 0.0
        
        //add && targets
        doneButton.addTarget(self, action: #selector(checkIfCardComplete(_:)), for: .touchUpInside)
        
        linkBtn.setImage(#imageLiteral(resourceName: "link"), for: .normal)
        linkBtn.entryType = .link
        cameraBtn.setImage(#imageLiteral(resourceName: "camera-alt"), for: .normal)
        cameraBtn.entryType = .image
        noteBtn.setImage(#imageLiteral(resourceName: "pen-square"), for: .normal)
        noteBtn.entryType = .text
        micBtn.setImage(#imageLiteral(resourceName: "microphone"), for: .normal)
        micBtn.entryType = .recording
    }
    
    func setupOpenView() {
        let entryBtns = [linkBtn, cameraBtn, noteBtn, micBtn]
        var xStart: CGFloat = 25
        for btn in entryBtns {
            if btn == micBtn {
                btn.frame = CGRect(x: xStart, y: 182.5, width: 20, height: 25)
            } else {
                btn.frame = CGRect(x: xStart, y: 185, width: 20, height: 20)
            }
            
            xStart += self.frame.width * 0.28
            btn.addTapGestureRecognizer {
                self.addEntry(btn)
            }
            self.animateIn(btn)
        }
        //frame
        cancelButton.frame = CGRect(x: self.frame.width - 75, y: 20, width: 60, height: 28)
        addTitleTV.frame   = CGRect(x: 15, y: 75, width: self.frame.width * 0.7, height: 81)
        addIconTV = EmojiDisplay(frame: CGRect(x: (self.frame.width * 0.7) + 25, y: 75, width: 81, height: 81), emoji: ThoughtIcon("🥘"))
        doneButton.frame = CGRect(x: 15, y: self.frame.height - 67, width: self.frame.width - 30, height: 57)
        errorLabel.frame = CGRect(x: 0, y: 250, width: self.frame.width, height: 15)
        let views = [cancelButton, addTitleTV, addIconTV, doneButton]
        for view in views {
            let nView = CardObject(view: view, availableIn: [.cardIsEditing, .cardIsDoneEditing])
            self.animateIn(nView.view)
        }
        self.addSubview(errorLabel)
    }
    
    
    @objc
    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: DashboardView())
        self.center.y = self.center.y + translation.y
        var position: CGFloat = 300
        panGesture.setTranslation(CGPoint.zero, in: self)
        if self.state == .collapsed {
            position = 700
        }
        if panGesture.state == .ended {
            if self.frame.origin.y > position {
                self.updateState(.collapsed)
                self.state = .collapsed
            } else {
                self.updateState(.cardIsEditing)
                self.state = .cardIsEditing
            }
        }
    }
    
    
    func addEntry(_ sender: newEntryButton) {
        if isTitleComplete == true && isIconComplete == true {
            self.delegate?.startNewEntry(sender.entryType)
        } else {
            showErrorLabel()
        }
        
    }
    
    func updateState(_ state: ThoughtCardState) {
        self.delegate?.updateState(state: state)
        switch state {
        case .collapsed:
            setupCard()
        default:
            setupOpenView()
        }
    }
    
    
    func animateOut(_ view: UIView) {
        UIView.animate(withDuration: 0.25) {
            view.alpha = 0.0
            view.removeFromSuperview()
        }
    }
    
    func animateIn(_ view: UIView) {
        view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.addSubview(view)
            view.alpha = 1.0
        }
    }
    
    @objc
    func checkIfCardComplete(_ sender: Any) {
        if isTitleComplete == true && isIconComplete == true {
            print("is lit")
            self.updateState(.collapsed)
        } else {
            showErrorLabel()
        }
    }
    
    func showErrorLabel() {
        UIView.animate(withDuration: 2.5, animations: {
            self.errorLabel.layer.opacity = 1.0
        }) { (true) in
            self.errorLabel.layer.opacity = 0.0
        }
    }
    
}
