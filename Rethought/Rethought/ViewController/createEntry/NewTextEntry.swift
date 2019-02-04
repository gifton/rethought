//
//  NewTextEntry.swift
//  rethought
//
//  Created by Dev on 1/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//let user add an entry with a title and description
class NewTextEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadContent()
        
        //add gesture to return home
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
        titleTextView.delegate = self
        detailTextView.delegate = self
    }
    
    //public objects
    //if user has previously added a text entry to the thought, set object
    public var entry: Entry?
    public var delegate       : ThoughtCardDelegate?
    public var parentThought  : Thought?
    
    //private objects
    private var newDescription: String = ""
    private var newTitle      : String = ""
    
    //if entry has been added already, set text to be entries info, else set it to welcome string
    var descriptionString: String {
        get {
            return entry?.detail ?? "Add a title for your entry"
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
    var detailTextView: UITextView = {
        let tv = UITextView()
        
        return tv
    }()
    var doneButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: "6271fc")
        btn.setAttributedTitle(btn.returnAttributedText(size: 12, font: .title, string: "Save"), for: .normal)
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
        //set frames
        titleTextView.frame       = CGRect(x: 15, y: 50, width: ViewSize.SCREEN_WIDTH - 30, height: 54)
        detailTextView.frame = CGRect(x: 25, y: 115, width: ViewSize.SCREEN_WIDTH - 50, height: 600)
        doneButton.frame          = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 99, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
        incompleteLabel.frame     = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 200, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
        
        titleTextView.textRect(forBounds: CGRect(x: 10, y: 0, width: titleTextView.frame.width - 10, height: titleTextView.frame.height))
        titleTextView.attributedText = titleTextView.returnAttributedText(color: .white, size: 14, font: .body, string: descriptionString)
        titleTextView.addLeftPadding(size: 10)
        detailTextView.attributedText = detailTextView.returnAttributedText(color: .black, size: 14, font: .body, string: "okay, start at the begining...")
        
        //set keyboard
        let toolBarKeyboardView = UIToolbar()
        toolBarKeyboardView.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnFromKeyboardClicked))
        toolBarKeyboardView.items = [btnDoneOnKeyboard]
        detailTextView.inputAccessoryView = toolBarKeyboardView
        
        //add to superview
        view.addSubview(titleTextView)
        view.addSubview(detailTextView)
        view.addSubview(doneButton)
        view.addSubview(incompleteLabel)
        
        //set target
        doneButton.addTarget(self, action: #selector(userPressedSave(_:)), for: .touchUpInside)
    }
}

extension NewTextEntry {
    
    //return home on left edge swipe
    @objc
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //create entry, return to controller
    @objc
    func userPressedSave(_ sender: UIButton) {
        
        //validate text views have been edited
        if self.newTitle != "" && self.newDescription != ""{
            let outEnt = Entry(type: .text, thoughtID: self.parentThought?.ID ?? "nil", detail: self.newDescription, date: Date(), title: self.newTitle)
            self.delegate?.addEntry(outEnt)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            self.view.animateTemporaryView(duration: 1.0, view: incompleteLabel)
        }
    }
    
    //set desciprion string to textview.text
    @objc
    func doneBtnFromKeyboardClicked(_ sender: Any) {
        self.newDescription = detailTextView.text
        detailTextView.resignFirstResponder()
    }
}

extension NewTextEntry: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.newDescription = textView.text
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}

extension NewTextEntry: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.newTitle = titleTextView.text!
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.newTitle = titleTextView.text!
    }
}
