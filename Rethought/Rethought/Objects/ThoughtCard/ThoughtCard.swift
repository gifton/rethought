//
//  ThoughtCard.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//custom card view
class ThoughtCard: UIView {
    
    //objects
    var delegate: ThoughtCardDelegate?
    var state: ThoughtCardState
    
    //gestures
    var panGestureRecognizer: UIPanGestureRecognizer?
    var tapRecognizer: UITapGestureRecognizer?
    
    //check if textViews is complete
    var isTitleComplete: Bool {
        get {
            return self.addTitleTV.isCompleted
        }
    }
    var isIconComplete: Bool {
        get {
            return self.addIconTV.isCompleted
        }
    }
    
    override init(frame: CGRect) {
        self.state = .collapsed
        super.init(frame: ViewSize.largeBar)
        
        setupCard()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        self.addGestureRecognizer(panGestureRecognizer!)
        
        tapRecognizer = UITapGestureRecognizer()
        self.addTapGestureRecognizer {
            self.tapOnNewThought(self.tapRecognizer!)
        }
    }
    
    //set with delegate
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
    private lazy var cancelButton = UIButton()
    private lazy var addTitleTV   = ReTextView()
    private lazy var addIconTV    = EmojiDisplay()
    private lazy var doneButton   = newEntryButton()
    private lazy var micBtn       = newEntryButton()
    private lazy var noteBtn      = newEntryButton()
    private lazy var linkBtn      = newEntryButton()
    private lazy var cameraBtn    = newEntryButton()
    private lazy var errorLabel   = UILabel()
}

extension ThoughtCard {
    
    func setupCard() {
        //animate all views out on collapse
        for view in subviews{
            animateOut(view)
        }
        
        //self styling
        self.blurBackground(type: .regular, cornerRadius: 30)
        self.layer.cornerRadius = 30
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor(hex: "DBDADB").cgColor
        self.isUserInteractionEnabled = true
        
        //frame
        newThoughtIntro.frame           = CGRect(x: 85, y: 35, width: 150, height: 30)
        iconLabel.frame                 = CGRect(x: 25, y: 35, width: 50, height: 50)
        timeSinceLastThoughtLabel.frame = CGRect(x: 85, y: 67.5, width: 200, height: 14)
        
        newThoughtIntro.padding             = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        newThoughtIntro.backgroundColor     = .cardLabelBackgroundDark
        newThoughtIntro.layer.cornerRadius  = 4
        newThoughtIntro.layer.masksToBounds = true
        iconLabel.layer.cornerRadius        = 6
        iconLabel.layer.masksToBounds       = true
        iconLabel.textAlignment             = .center
        iconLabel.backgroundColor           = .cardLabelBackgroundDark
        iconLabel.addText(size: 24, font: .body, string: "💭")
        newThoughtIntro.addText(color: UIColor(hex: "4A4A4A"), size: 12, font: .body, string: "What's on your mind?")
        timeSinceLastThoughtLabel.addText(color: .black, size: 10, font: .bodyLight, string: "Last new thought: 4 days")
        
        animateIn(iconLabel)
        animateIn(newThoughtIntro)
        animateIn(timeSinceLastThoughtLabel)
        
        //style
        cancelButton.addAttText(color: .white, size: 16, font: .body, string: "cancel")
        cancelButton.backgroundColor = .darkGray
        cancelButton.layer.cornerRadius = 3
        addTitleTV.color = UIColor(hex: "5D5D5D")
        addTitleTV.size = 14
        addTitleTV.placeholder = "Type a brief description"
        addTitleTV.backgroundColor = .cardLabelBackgroundLight
        addTitleTV.layer.cornerRadius = 6
        addTitleTV.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        addIconTV.backgroundColor = .cardLabelBackgroundLight
        doneButton.backgroundColor = UIColor(hex: "6271fc")
        doneButton.layer.cornerRadius = 19
        doneButton.layer.masksToBounds = true
        doneButton.addAttText(color: UIColor(hex: "ffffff"), size: 16, font: .title, string: "Done")
        errorLabel.attributedText = errorLabel.returnAttributedText(color: .black, size: 14, font: .bodyLight, string: "please add a title and icon")
        errorLabel.textAlignment = .center
        errorLabel.layer.opacity = 0.0
        
        //add && targets
        doneButton.addTarget(self, action: #selector(checkIfCardComplete(_:)), for: .touchUpInside)
        
        linkBtn.setImage(#imageLiteral(resourceName: "link-dark"), for: .normal)
        cameraBtn.setImage(#imageLiteral(resourceName: "camera-dark"), for: .normal)
        noteBtn.setImage(#imageLiteral(resourceName: "pen-square-dark"), for: .normal)
        micBtn.setImage(#imageLiteral(resourceName: "microphone-dark"), for: .normal)
        
        linkBtn.entryType = .link
        cameraBtn.entryType = .image
        noteBtn.entryType = .text
        micBtn.entryType = .recording
    }
    
    //build view for open state
    func setupOpenView() {
        let entryBtns = [linkBtn, cameraBtn, noteBtn, micBtn]
        var xStart: CGFloat = 12.5
        for btn in entryBtns {
            if btn == micBtn {
                btn.frame = CGRect(x: xStart, y: 179.5 + 25, width: 20*1.8, height: 25*1.8)
            } else {
                btn.frame = CGRect(x: xStart, y: 185 + 25, width: 20*1.8, height: 20*1.8)
            }
            
            xStart += self.frame.width * 0.28
            btn.addTapGestureRecognizer {
                self.addEntry(btn)
            }
            self.animateIn(btn)
        }
        
        //frame
        cancelButton.frame = CGRect(x: self.frame.width - 85, y: 35, width: 60, height: 28)
        cancelButton.addTarget(self, action: #selector(cancelThought(_:)), for: .touchUpInside)
        addTitleTV.frame   = CGRect(x: 15, y: 100, width: self.frame.width * 0.7, height: 81)
        addTitleTV.connector = self.delegate
        addIconTV = EmojiDisplay(frame: CGRect(x: (self.frame.width * 0.7) + 25, y: 100, width: 81, height: 81), emoji: ThoughtIcon("🥘"))
        doneButton.frame = CGRect(x: 15, y: self.frame.height - 74, width: self.frame.width - 30, height: 59)
        errorLabel.frame = CGRect(x: 0, y: 250, width: self.frame.width, height: 15)
        let views = [cancelButton, addTitleTV, addIconTV, doneButton]
        for view in views {
            let nView = CardObject(view: view, availableIn: [.cardIsEditing, .cardIsDoneEditing])
            nView.layer.masksToBounds = true
            nView.view.layer.masksToBounds = true
            self.animateIn(nView.view)
        }
        self.addSubview(errorLabel)
    }
    
    //allow user to slide card to middle of view
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
    
    //allow user to tap on card and set open state
    //card waits for keyboard interaction to set frame.origin.y -= keyboard.size.height
    @objc
    func tapOnNewThought(_ tapper: UITapGestureRecognizer) {
        if state == .collapsed {
            self.delegate?.addThoughtComponents(title: addTitleTV.text, icon: addIconTV.emoji)
            self.updateState(.cardIsDoneEditing)
            self.state = .cardIsDoneEditing
        }
        
    }
    
    //set state to closed, remove entry visual confirmations, delete thought components
    @objc
    func cancelThought(_ sender: Any) {
        self.updateState(.collapsed)
        self.state = .collapsed
    }
    
    //alert controller of an entry addition request
    func addEntry(_ sender: newEntryButton) {
        if isTitleComplete == true && isIconComplete == true {
            self.delegate?.addThoughtComponents(title: addTitleTV.text, icon: addIconTV.emoji)
            self.delegate?.startNewEntry(sender.entryType)
            
        } else {
            showErrorLabel()
        }
        
    }
    
    //set new state
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
        UIView.animate(withDuration: 0.75) {
            self.addSubview(view)
            view.alpha = 1.0
        }
    }
    
    //card validation
    @objc
    func checkIfCardComplete(_ sender: Any) {
        if textViewCompleted {
            self.delegate?.addThoughtComponents(title: addTitleTV.text, icon: addIconTV.emoji)
            self.delegate?.didPressSave()
            self.updateState(.collapsed)
        } else {
            showErrorLabel()
        }
    }
    
    private var textViewCompleted: Bool {
        if isTitleComplete == true && isIconComplete == true {
            return true
        } else {
            return false
        }
        
    }
    
    //display error message
    func showErrorLabel() {
        animateTemporaryView(duration: 1.0, view: errorLabel)
    }
    
}

//show visual confirmation of new thought added
extension ThoughtCard {
    public func didAddEntry(_ type: Entry.EntryType) {
        switch type {
        case .link:
            self.linkBtn.addBorders(edges: [.bottom], color: UIColor(hex: "13ACBE"), thickness: 4)
        case .image:
            self.cameraBtn.addBorders(edges: [.bottom], color: UIColor(hex: "13ACBE"), thickness: 4)
        case .recording:
            self.micBtn.addBorders(edges: [.bottom], color: UIColor(hex: "13ACBE"), thickness: 4)
        case .text:
            self.noteBtn.addBorders(edges: [.bottom], color: UIColor(hex: "13ACBE"), thickness: 4)
        }
    }
}
