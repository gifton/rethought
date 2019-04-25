//
//  MSGCenter.swift
//  Rethought
//
//  Created by Dev on 4/23/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

// view that user can add new thought and/or new entries
class MSGCenter: UIView {
    init(frame: CGRect, connector: MSGConnector) {
        self.msgHandler = MSGHandler()
        self.connector = connector
        super.init(frame: frame)
        
        setViews()
    }
    
    var connector: MSGConnector
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //make objects animateable(?)
    //add variables and buttons with entryTypes and buttonTypes
    
    public var msgHandler: MSGHandler
    private var placeHolder: String {
        if (msgHandler.currentNewEntryType == .none) {
            return "Give your thought a short title"
        }
        
        switch msgHandler.currentNewEntryType {
        case .text:
            return "Give your note a title"
        case .image:
            return "Give your image a title"
        case .link:
            return "Give your link a title"
        default:
            return "Give your recording a title"
        }
    }
    
    // MARK: private objects
    public var textView: UITextView = {
        let tv = UITextView()
        tv.font = Device.font.formalBodyText()
        tv.textColor = Device.colors.lightGray
        tv.frame = CGRect(x: 10, y: 50, width: Device.size.paddedMaxWidth, height: 40)
        
        return tv
    }()
    private var textButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "note_clay"), for: .normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.entryType = .text
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var linkButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "link_clay"), for: .normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.entryType = .link
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var recordingButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "recording_clay"), for: .normal)
        btn.frame.size = CGSize(width: 13.74, height: 20)
        btn.entryType = .recording
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var imageButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "camera_clay"), for: .normal)
        btn.frame.size = CGSize(width: 24, height: 20)
        btn.imageView?.tintColor = .red
        btn.entryType = .image
        btn.messageButtonType = .entry
        
        return btn
    }()
    private var sendButton: MessageButton = {
        let btn = MessageButton()
        let attrString = NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.font : Device.font.mediumTitle(ofSize: .small),
                                                                         NSAttributedString.Key.foregroundColor : UIColor.white])
        btn.setAttributedTitle(attrString, for: .normal)
        btn.backgroundColor = Device.colors.blue
        btn.layer.cornerRadius = 7
        btn.entryType = .none
        btn.messageButtonType = .send
        
        return btn
    }()
    private var cancelButton: MessageButton = {
        let btn = MessageButton()
        let attrString = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font : Device.font.mediumTitle(ofSize: .small), NSAttributedString.Key.foregroundColor : UIColor.white])
        btn.setAttributedTitle(attrString, for: .normal)
        btn.backgroundColor = Device.colors.recording
        btn.layer.cornerRadius = 7
        btn.entryType = .none
        btn.messageButtonType = .send
        
        return btn
    }()

    private var newRecordingView: UIView = {
        let view = UIView()
        view.backgroundColor = Device.colors.recording
        
        return view
    }()
    private var newImageView: UIView = {
        let view = UIView()
        view.backgroundColor = Device.colors.image
        
        return view
    }()
    private var newLinkView: UIView = {
        let view = UIView()
        view.backgroundColor = Device.colors.link
        
        return view
    }()
    private var newNoteView: UIView = {
        let view = UIView()
        view.backgroundColor = Device.colors.note
        
        return view
    }()
}

//placing objects funcs
extension MSGCenter {
    private func setViews() {
        
        // add all objects to view
        textView.delegate = self
        textView.text = placeHolder
        sendButton.frame = CGRect(x: Device.size.width - 65, y: 10, width: 50, height: 30)
        sendButton.addTapGestureRecognizer { self.buttonTapped(sender: self.sendButton) }
        
        addSubview(textView)
        addSubview(sendButton)
        
        let entryButtons = [textButton, linkButton, recordingButton, imageButton]
        var startX: CGFloat = 15.0
        let startY: CGFloat = 10
        for btn in entryButtons {
            btn.frame = CGRect(x: startX, y: startY, width: btn.frame.width, height: btn.frame.height)
            btn.addTapGestureRecognizer { self.buttonTapped(sender: btn) }
            addSubview(btn)
            startX += (btn.frame.width + 25)
        }
        
        
        //check buttons
        checkButtons()
        
        //updatePosition()
        updatePosition()
    }
    
    private func setRegularView() {
        //check and resize view if necessary
        
        if !(frame.height == msgHandler.currentSize.rawValue) {
            //call delegate to change size
        }
        //remove all views that are not in view
        if !(msgHandler.currentNewEntryType == .none) {
            switch msgHandler.currentNewEntryType {
            case .text: newNoteView.removeFromSuperview()
            case .link: newLinkView.removeFromSuperview()
            case .recording: newRecordingView.removeFromSuperview()
            default: newImageView.removeFromSuperview()
            }
        }
        
        for view in subviews {
            guard let btn: MessageButton = view as? MessageButton else { continue }
            if !(msgHandler.isAvailable(btn: btn)) {
                btn.removeFromSuperview()
            }
        }
        //check if all views are in super view
        let regularSubviews = [textButton, linkButton, recordingButton, imageButton, sendButton, textView]
        // if not, add view and add frame
        for view in regularSubviews {
            if !(view.isDescendant(of: self)) {
                addSubview(view)
            }
        }
        
        //set textView title
        textView.text = placeHolder
        
        //check for button availability
        checkButtons()
    }
    
    private func setRegularAndKeybardView() {
        // check and resize view if necessary
        if !(frame.height == msgHandler.currentSize.rawValue) {
            // call delegate to change size
        }
        
        // have message handler return list of bools
        // zip list of bools to views in super view
        // remove form superview if false
        // check if its in the view already if true, if not add it
        let eligibility = msgHandler.checkForEligibility(in: self)
        for (eligible, view) in zip(eligibility, subviews) {
            if !(eligible) {
                view.removeFromSuperview()
            } else if eligible && !(view.isDescendant(of: self)) {
                addSubview(view)
            }
            continue
        }
        
        //set textView title
        textView.text = placeHolder
        //check for button availability
        checkButtons()
    }
    
    private func setEntryView() {
        //get entry type from msgHandler
        // get size of entryTypeView
        // send size request to delegate
        // switch entrytype and run specific type's show func
        //update textView
        //check for buttons
    }
    
    private func setEntryAndKeyboardView() {
        //add entryTypeView
        //update textView
        //check for buttons
    }
}


extension MSGCenter {

    
    private func updatePosition() {
        switch msgHandler.currentPosition {
        case .regular: setRegularView()
        default: setEntryView()
        }
    }
    

    
    private func checkButtons() {
        // check msgHandler for what has and hasnt been complete
        // update buttons opacity with .isEnabled() and .isDisabled()
        if !(msgHandler.didStartThought) {
            print("found thought to be started")
            sendButton.isDisabled()
            textButton.isDisabled()
            imageButton.isDisabled()
            linkButton.isDisabled()
            recordingButton.isDisabled()
            sendButton.isDisabled()
        } else {
            sendButton.isEnabled()
            textButton.isEnabled()
            imageButton.isEnabled()
            linkButton.isEnabled()
            recordingButton.isEnabled()
            sendButton.isEnabled()
        }
        
        
    }
    
    private func buttonTapped(sender: MessageButton) {
        switch sender.messageButtonType {
        case .cancel: cancel()
        case .send: send()
        case .entry: msgHandler.currentNewEntryType = sender.entryType; setEntryView()
        case .open: setEntryAndKeyboardView()
        case .close: setEntryView()
        }
    }
    
}

//action calls
extension MSGCenter {
    private func cancel() {
        //check what state msgCenter is in
        //  close keyboard
        //  close keyboard and new entry
        //  close entry
    }
    
    private func send() {
        //check title from msgHandler
        //check icon from msgHandler
        //check if location is available
        // build thoughtPreview
        // send thoughtpreview to controller
        
    }
    
    private func updateIcon() {
        //tell controller new icon from MSGHandler
    }
    private func updateTitle() {
        //tell controller new title from MSGHandler
    }
    
    private func showNoteEntry() {
        //check if there is an entry currently open, close it
        // add subview of note entry
        //update msgHandler
    }
    private func showRecordingEntry() {
        //check if there is an entry currently open, close it
        // add subview of recording entry
        //update msgHandler
    }
    private func showImageEntry() {
        //check if there is an entry currently open, close it
        // add subview of image entry
        //update msgHandler
    }
    private func showLinkEntry() {
        //check if there is an entry currently open, close it
        // add subview of link entry
        //update msgHandler
    }
    
}

extension MSGCenter: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("began typing new thought")
        textView.text = ""
        msgHandler.didStartThought = true
        checkButtons()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = placeHolder
    }
}
