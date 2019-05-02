
import Foundation
import UIKit

// view that user can add new thought and/or new entries
class MSGCenter: UIView {
    init(frame: CGRect, connector: MSGConnector) {
        self.msgHandler = MSGCenterHandler()
        self.connector = connector
        super.init(frame: frame)
        
        setViews()
    }
    
    public var isShowingEntry: Bool {
        get {
            return !(msgHandler.currentEntryType == .none)
        }
    }
    public var currentEntryType: MSGContext.type {
        return msgHandler.currentEntryType
    }
    
    var connector: MSGConnector
    public var delegate: MSGCenterDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // make objects animateable(?)
    // add variables and buttons with entryTypes and buttonTypes
    
    public var msgHandler: MSGCenterHandler
    
    // MARK: private objects
    public var textView: UITextView = {
        let tv = UITextView()
        tv.font = Device.font.formalBodyText()
        tv.textColor = Device.colors.lightGray
        tv.frame = CGRect(x: 10, y: 50, width: Device.size.paddedMaxWidth, height: 40)
        tv.addDoneButtonOnKeyboard()
        
        return tv
    }()
    private var textButton: MessageButton = {
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
    private var imageButton: MessageButton = {
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
    private var cancelButton: MessageButton = {
        let btn = MessageButton()
        let attrString = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font : Device.font.mediumTitle(ofSize: .small), NSAttributedString.Key.foregroundColor : UIColor.white])
        btn.setAttributedTitle(attrString, for: .normal)
        btn.backgroundColor = Device.colors.recording
        btn.layer.cornerRadius = 7
        btn.entryType = .none
        btn.messageButtonType = .cancel
        
        return btn
    }()

    public var newRecordingView: NewRecordingView = {
        let view = NewRecordingView()
        view.backgroundColor = Device.colors.recording
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    public var newImageView: NewImageView = {
        let view = NewImageView()
        view.backgroundColor = Device.colors.image
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    public var newLinkView: NewLinkView = {
        let view = NewLinkView()
        view.backgroundColor = Device.colors.link
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    public var newNoteView: NewNoteView = {
        let view = NewNoteView()
        view.backgroundColor = Device.colors.note
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
}

// placing objects funcs
extension MSGCenter {
    private func setViews() {
        
        // add all objects to view
        textView.delegate = self
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
        
        
        // check buttons and text
        checkButtons()
        updateStaticText()
        
        // updatePosition()
        updatePosition()
    }
    
    private func setRegularView() {
        // check and resize view if necessary
        
        if !(frame.height == msgHandler.currentSize.rawValue) {
            // call delegate to change size
        }
        // remove all views that are not in view
        if !(msgHandler.currentEntryType == .none) {
            switch msgHandler.currentEntryType {
            case .note: newNoteView.removeFromSuperview()
            case .link: newLinkView.removeFromSuperview()
            case .recording: newRecordingView.removeFromSuperview()
            default: newImageView.removeFromSuperview()
            }
        }
        
        // set textView title
        textView.text = msgHandler.textViewPlaceHolder
        
        // check for buttons and text
        checkButtons()
        updateStaticText()
    }
    
    private func setEntryView() {
        
        //remove any previous entry view
        removeEntryView()
        // send willShow(ofType:) request to delegate
        connector.entryWillShow(ofType: msgHandler.currentSize)
        
        // switch entrytype and run specific type's show func
        switch msgHandler.currentEntryType {
        case .photo: showImageEntry()
        case .link: showLinkEntry()
        case .recording: showRecordingEntry()
        default: showNoteEntry()
        }
        
        // update textView
        textView.text = msgHandler.textViewPlaceHolder
        // check for buttons and text
        checkButtons()
        updateStaticText()
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
//        if !(msgHandler.didCompleteThought) {
//            sendButton.isDisabled()
//            textButton.isDisabled()
//            imageButton.isDisabled()
//            linkButton.isDisabled()
//            recordingButton.isDisabled()
//            sendButton.isDisabled()
//        } else if msgHandler.didStartThought {
//            sendButton.isEnabled()
//        }
//
//        if (msgHandler.didCompleteThought == true) {
//            textButton.isEnabled()
//            imageButton.isEnabled()
//            linkButton.isEnabled()
//            recordingButton.isEnabled()
//            sendButton.isEnabled()
//        }
    }
    
    private func buttonTapped(sender: MessageButton) {
        switch sender.messageButtonType {
        case .cancel:
            cancel()
        case .send:
            if send() {
//                delegate.didSendMessage()
                connector.testConnection()
                return
            } else { handleFailedSend(); connector.testConnection() }
        case .entry:
            msgHandler.currentEntryType = sender.entryType
            delegate.didTapEntry(ofType: msgHandler.currentSize, completion: setEntryView())
        default: setEntryView()
        }
        checkButtons()
    }
    
    
    private func handleFailedSend() { print("failed to save, missing content") }
}

// action calls
extension MSGCenter {
    private func cancel() {
        // check what state msgCenter is in
        switch msgHandler.currentPosition {
        case .newEntry: updatePosition()
        default: resignFirstResponder(); textView.resignFirstResponder(); updatePosition()
        }
    }
    
    private func send() -> Bool {
        // check title from msgHandler
        guard let title = msgHandler.thoughtTitle else { return false }
        // check icon from msgHandler
        guard let icon = msgHandler.thoughtIcon else { return false }
        // send context to controller
        connector.save(withTitle: title, withIcon: icon)
        
        return true
    }
    
    private func updateIcon() {
        // tell controller new icon from MSGHandler
    }
    private func updateTitle() {
        // tell controller new title from MSGHandler
        guard let thoughtIcon = msgHandler.thoughtIcon else { return }
        connector.updateIcon(newIcon: thoughtIcon)
    }
    
    private func showNoteEntry() {
        // add subview of note entry
        addSubview(newNoteView)
        newNoteView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                              paddingTop: 115, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        // update msgHandler
        msgHandler.currentEntryType = .note
        msgHandler.currentPosition = .newEntry
        //check buttons
        checkButtons()
    }
    private func showRecordingEntry() {
        // add subview of note entry
        addSubview(newRecordingView)
        newRecordingView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                                   paddingTop: 115, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        // update msgHandler
        msgHandler.currentEntryType = .recording
        msgHandler.currentPosition = .newEntry
        //check buttons
        checkButtons()
    }
    private func showImageEntry() {
        // add subview of note entry
        addSubview(newImageView)
        newImageView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                               paddingTop: 115, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        // update msgHandler
        msgHandler.currentEntryType = .photo
        msgHandler.currentPosition = .newEntry
        //check buttons
        checkButtons()
    }
    private func showLinkEntry() {
        // add subview of note entry
        addSubview(newLinkView)
        newLinkView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                              paddingTop: 115, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        // update msgHandler
        msgHandler.currentEntryType = .link
        msgHandler.currentPosition = .newEntry
        //check buttons
        checkButtons()
    }
    
    // if entry view is currently showing, remove it before adding new one
    public func removeEntryView() {
        // check which entry is currently in progressfrom msgHandler
        // and remove it
        switch msgHandler.currentEntryType {
        case .photo:
            newLinkView.removeFromSuperview()
            newNoteView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            msgHandler.currentEntryType = .photo
        case .link:
            newImageView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            newNoteView.removeFromSuperview()
            msgHandler.currentEntryType = .link
        case .recording:
            newImageView.removeFromSuperview()
            newLinkView.removeFromSuperview()
            newNoteView.removeFromSuperview()
            msgHandler.currentEntryType = .recording
        case .note:
            newImageView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            newLinkView.removeFromSuperview()
            msgHandler.currentEntryType = .note
        default:
            newImageView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            newLinkView.removeFromSuperview()
            newNoteView.removeFromSuperview()
            msgHandler.currentEntryType = .none
        }
        //check buttons
        checkButtons()
        connector.isDoneEditing()
    }
    
    // set text on send button and textView
    func updateStaticText() {
        textView.text = msgHandler.textViewPlaceHolder
        sendButton.setAttributedTitle(msgHandler.sendButtonTitle, for: .normal)
    }
}

extension MSGCenter: UITextViewDelegate {
    //once editing begins on textView, set didStartThought: true
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        msgHandler.didStartThought = true
        checkButtons()
    }

    // once done editing, set title to textView
    func textViewDidEndEditing(_ textView: UITextView) {
        updateStaticText()
        checkButtons()
        msgHandler.thoughtTitle = textView.text
    }
}
