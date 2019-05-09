//
//  EntryMaker.swift
//  Rethought
//
//  Created by Dev on 5/2/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MSGCenter: UIView {
    init(frame: CGRect, connector: MSGConnector, isFull: Bool = true) {
        self.connector = connector
        super.init(frame: frame)
        setInitialView(isFull)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // public vars
    // connector connects with controller
    var connector: MSGConnector
    // delegate connects with conversatiuon handler
    public var delegate: MSGCenterDelegate!
    public var hasStartedThought: Bool = false
    public var hasCompletedThought: Bool = false
    public var isShowingEntry: Bool {
        get {
            return !(currentEntryType == .none)
        }
        set {
            if newValue == false {
                connector.isDoneEditing()
            }
        }
    }
    
    private var currentEntryType: EntryType = .none
    private var title: String?
    private var thoughtIcon = ThoughtIcon("🚦")
    private var entryBuilders = [EntryBuilder]()
    
    // make objects animateable(?)
    // add variables and buttons with entryTypes and buttonTypes
    // MARK: private objects
    public var textView: UITextView = {
        let tv = UITextView()
        tv.font = Device.font.formalBodyText()
        tv.textColor = Device.colors.lightGray
        tv.frame = CGRect(x: 10, y: 50, width: Device.size.paddedMaxWidth, height: 40)
        tv.addDoneButtonOnKeyboard()
        
        return tv
    }()
    private var noteButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "note_clay"), for: .normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.entryType = .note
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
    private var photoButton: MessageButton = {
        let btn = MessageButton()
        btn.setImage(#imageLiteral(resourceName: "camera_clay"), for: .normal)
        btn.frame.size = CGSize(width: 24, height: 20)
        btn.imageView?.tintColor = .red
        btn.entryType = .photo
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
    
    public var newRecordingView: NewRecordingView = {
        let view = NewRecordingView()
        view.backgroundColor = Device.colors.recording
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    public var newLinkView: NewLinkView = {
        let view = NewLinkView()
        view.backgroundColor = Device.colors.link
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    public var newNoteView: MSGCenterNoteView!
    public var newPhotoView: MSGCenterPhotoView!
}

// setting view methods
extension MSGCenter {
    public func setInitialView(_ isFull: Bool = true) {
        
        // remove any remaining entry views
        _ = removeEntryView()
        // add buttons to view
        // TODO: Make this a stack view
        var startX: CGFloat = 15.0
        let startY: CGFloat = 10
        for btn in [noteButton, linkButton, recordingButton, photoButton] {
            
            if !(btn.isDescendant(of: self)) {
                btn.frame = CGRect(x: startX, y: startY, width: btn.frame.width, height: btn.frame.height)
                btn.addTapGestureRecognizer { self.buttonTapped(sender: btn) }
                addSubview(btn)
                startX += (btn.frame.width + 25)
            }
            
        }
        
        // add all objects to view
        textView.delegate = self
        sendButton.frame = CGRect(x: Device.size.width - 65, y: 10, width: 50, height: 30)
        sendButton.addTapGestureRecognizer { self.buttonTapped(sender: self.sendButton) }
        
        //set text view
        textView.text = "give your thought a short title"
        
        // if the initializer called for a full view, add the text view and send button
        // TODO: add else statement for minimize button
        if isFull {
            if !(textView.isDescendant(of: self)) {
                addSubview(textView)
                addSubview(sendButton)
            }
        }
        connector.isDoneEditing()
    }
    
    // display specific entry, set anchors
    func showEntry(ofType type: EntryType) {
        // put haptic response in showEntry(type:) for confirmation of entry appearance validation
        let ggenerator = UISelectionFeedbackGenerator()
        ggenerator.selectionChanged()
        _ = removeEntryView()
        var view = UIView()
        switch type {
        case .link:
            view = newLinkView
            currentEntryType = .link
            textView.text = "give your link a title"
        case .note:
            newNoteView = MSGCenterNoteView(bus: self)
            view = newNoteView
            currentEntryType = .note
            textView.text = "give your note a title"
        case .recording:
            view = newRecordingView
            currentEntryType = .recording
            textView.text = "give your recording a description"
        case .photo:
            newPhotoView = MSGCenterPhotoView(withBus: self)
            view = newPhotoView
            currentEntryType = .photo
            textView.text = "give your photo a title"
        default:
            textView.text = "Give your thought a short title"
            return
        }
        addSubview(view)
        view.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                       paddingTop: 115, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
    }
}

// button actions
extension MSGCenter {
    private func buttonTapped(sender: MessageButton) {
        let generator = UINotificationFeedbackGenerator()
        switch sender.messageButtonType {
        case .entry:
            connector.entryWillShow(ofType: getSizeFrom(entryType: sender.entryType))
            delegate.didTapEntry(ofType: getSizeFrom(entryType: sender.entryType), completion: showEntry(ofType: sender.entryType))
        case .send:
            if send() {
                hasCompletedThought = true
                delegate.didSendMessage()
                generator.notificationOccurred(.success)
                connector.isDoneEditing()
            } else { handleFailedSave() }
        }
    }
    
    // send thought or entry after creation
    private func send() -> Bool {
        
        guard let title = title else {
            print("has not saved thought")
            return false
        }
        
        // if there is not thought, save one first
        if !(hasCompletedThought) {
            
            connector.save(withTitle: title, withIcon: thoughtIcon)
            print("save was successful!")
            return true
        }
        
        return attemptSending(entryOfType: currentEntryType, with: title)
    }
    
    private func attemptSending(entryOfType type: EntryType, with payload: String) -> Bool {
        switch type {
        case .photo: return newPhotoView.requestContent(with: payload)
        default: newNoteView.requestSave(withTitile: payload); return true
        }
    }
    
    private func handleFailedSave() { print("unable to save thought, missing title component")}
}


// adding and removing views
extension MSGCenter {
    func getSizeFrom(entryType: EntryType) -> MSGContext.size {
        switch entryType {
        case .photo: return .photo
        case .link: return .link
        case .note: return .note
        case .recording: return .recording
        default: return .recording
        }
    }
    public func removeEntryView() -> Bool {

        switch  currentEntryType{
        case .link: newLinkView.removeFromSuperview()
        case .photo:
            newPhotoView.endSession()
            newPhotoView.removeFromSuperview()
        case .recording: newRecordingView.removeFromSuperview()
        case .note: newNoteView.removeFromSuperview()
        default: return false
        }
        currentEntryType = .none
        return true
    }
    
}

// text view delegate
// textView delegate
extension MSGCenter: UITextViewDelegate {
    //once editing begins on textView, set didStartThought: true
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        
    }
    func textViewDidChange(_ textView: UITextView) {
        hasStartedThought = true
        title = textView.text
    }
}

extension MSGCenter: EntryComponentBus {
    func save<K>(withpayload payload: K) where K : EntryBuilder {
        print (payload.type)
        entryBuilders.append(payload)
        connector.insert(entry: payload)
    }
    func entryDidRequestCancel() {
        _ = removeEntryView()
        connector.isDoneEditing()
    }
}
