//
//  NewTextEntry.swift
//  rethought
//
//  Created by Dev on 1/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class NewTextEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadContent()
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
        titleTextView.delegate = self
        descriptionTextView.delegate = self
    }
    
    public var entry: Entry?
    public var delegate       : ThoughtCardDelegate?
    public var parentThought  : Thought?
    private var newDescription: String = ""
    private var newTitle      : String = ""
    var descriptionString: String {
        get {
            return entry?.description ?? "Add a title for your entry"
        }
    }
    var titleString: String {
        get {
            return entry?.title ?? "okay, start at the begining"
        }
    }
    
    var titleTextView: UITextField = {
        let tv = UITextField()
        tv.backgroundColor = .darkGray
        tv.layer.cornerRadius = 6
        tv.layer.masksToBounds = true
        
        return tv
    }()
    var descriptionTextView: UITextView = {
        let tv = UITextView()
        
        return tv
    }()
    var doneButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: "6271fc")
        btn.setAttributedTitle(btn.addAttributedText(size: 12, font: .title, string: "Save"), for: .normal)
        btn.layer.cornerRadius = 6
        
        return btn
    }()
    
    let incompleteLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 5
        lbl.addText(color: .white, size: fontSize.small.rawValue, font: .bodyLight, string: "Please enter a title and description")
        lbl.textAlignment = .center
        lbl.backgroundColor = .darkBackground
        lbl.layer.masksToBounds = true
        lbl.layer.opacity = 0.0
        
        return lbl
    }()
    
    func loadContent() {
        
        titleTextView.frame       = CGRect(x: 15, y: 50, width: ViewSize.SCREEN_WIDTH - 30, height: 54)
        descriptionTextView.frame = CGRect(x: 25, y: 115, width: ViewSize.SCREEN_WIDTH - 50, height: 600)
        doneButton.frame          = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 99, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
        incompleteLabel.frame     = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 200, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
        
        titleTextView.attributedText = titleTextView.addAttributedText(color: .white, size: 14, font: .body, string: descriptionString)
        descriptionTextView.attributedText = descriptionTextView.addAttributedText(color: .black, size: 14, font: .body, string: "okay, start at the begining...")
        
        view.addSubview(titleTextView)
        view.addSubview(descriptionTextView)
        view.addSubview(doneButton)
        view.addSubview(incompleteLabel)
        
        doneButton.addTarget(self, action: #selector(userPressedSave(_:)), for: .touchUpInside)
        
        print (doneButton)
    }
}

extension NewTextEntry {
    @objc
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    func userPressedSave(_ sender: UIButton) {
        if self.newTitle != "" && self.newDescription != ""{
            let entry = Entry(type: .text, thoughtID: self.parentThought?.ID ?? "nil", description: self.newDescription, date: Date(), icon: self.parentThought?.icon ?? "🥗")
            self.delegate?.addEntry(entry)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            self.view.animateTemporaryView(duration: 1.0, view: incompleteLabel)
        }
    }
}

extension NewTextEntry: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.newDescription = textView.text
    }
    
}

extension NewTextEntry: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        textField.resignFirstResponder()
        self.newTitle = titleTextView.text!
        return false
    }
}
