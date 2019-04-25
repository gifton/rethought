
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
    
    // make objects animateable(?)
    // add variables and buttons with entryTypes and buttonTypes
    
    public var msgHandler: MSGHandler
    
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
        
        for view in subviews {
            guard let btn: MessageButton = view as? MessageButton else { continue }
            if !(msgHandler.isAvailable(btn: btn)) {
                btn.removeFromSuperview()
            }
        }
        // check if all views are in super view
        let regularSubviews = [textButton, linkButton, recordingButton, imageButton, sendButton, textView]
        // if not, add view and add frame
        for view in regularSubviews {
            if !(view.isDescendant(of: self)) {
                addSubview(view)
            }
        }
        
        // set textView title
        textView.text = msgHandler.textViewPlaceHolder
        
        // check for buttons and text
        checkButtons()
        updateStaticText()
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
        case .image: showImageEntry()
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
    
    private func setEntryAndKeyboardView() {
        // add entryTypeView
        // update textView
        // check for buttons
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
            sendButton.isDisabled()
            textButton.isDisabled()
            imageButton.isDisabled()
            linkButton.isDisabled()
            recordingButton.isDisabled()
            sendButton.isDisabled()
        } else { sendButton.isEnabled() }
        
        if (msgHandler.didCompleteThought == true) {
            textButton.isEnabled()
            imageButton.isEnabled()
            linkButton.isEnabled()
            recordingButton.isEnabled()
            sendButton.isEnabled()
        }
        
        switch msgHandler.currentEntryType {
        case .link:
            linkButton.imageView!.image = linkButton.imageView!.image!.withRenderingMode(.alwaysTemplate)
            linkButton.imageView!.tintColor = UIColor.red
        case .image:
            imageButton.imageView!.image = imageButton.imageView!.image!.withRenderingMode(.alwaysTemplate)
            imageButton.imageView!.tintColor = UIColor.red
        case .note:
            textButton.imageView!.image = textButton.imageView!.image!.withRenderingMode(.alwaysTemplate)
            textButton.imageView!.tintColor = UIColor.red
        case .recording:
            recordingButton.imageView!.image = recordingButton.imageView!.image!.withRenderingMode(.alwaysTemplate)
            recordingButton.imageView!.tintColor = UIColor.red
        default:
            break
        }
    }
    
    private func buttonTapped(sender: MessageButton) {
        switch sender.messageButtonType {
        case .cancel: cancel()
        case .send: if send() { return } else { handleFailedSend() }
        case .entry: msgHandler.currentEntryType = sender.entryType; setEntryView()
        case .open: setEntryAndKeyboardView()
        case .close: setEntryView()
        }
        checkButtons()
    }
    
    
    private func handleFailedSend() {}
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
        //check buttons
        checkButtons()
    }
    private func showImageEntry() {
        // add subview of note entry
        addSubview(newImageView)
        newImageView.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                               paddingTop: 115, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        // update msgHandler
        msgHandler.currentEntryType = .image
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
        //check buttons
        checkButtons()
    }
    
    public func removeEntryView() {
        // check which entry is currently in progressfrom msgHandler
        // and remove it
        switch msgHandler.currentEntryType {
        case .image:
            newLinkView.removeFromSuperview()
            newNoteView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
        case .link:
            newImageView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            newNoteView.removeFromSuperview()
        case .recording:
            newImageView.removeFromSuperview()
            newLinkView.removeFromSuperview()
            newNoteView.removeFromSuperview()
        case .note:
            newImageView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            newLinkView.removeFromSuperview()
        default:
            newImageView.removeFromSuperview()
            newRecordingView.removeFromSuperview()
            newLinkView.removeFromSuperview()
            newNoteView.removeFromSuperview()
            msgHandler.currentEntryType = .none
        }
        //check buttons
        checkButtons()
    }
    
    func updateStaticText() {
        textView.text = msgHandler.textViewPlaceHolder
        sendButton.setAttributedTitle(msgHandler.sendButtonTitle, for: .normal)
    }
    
    public func didHideKeyboard() {
        if msgHandler.currentPosition == MSGContext.position.newEntryAndKeyboard {
            msgHandler.currentPosition = .newEntry
        } else if msgHandler.currentPosition == MSGContext.position.regularAndKeyboard {
            msgHandler.currentPosition = .regular
        }
        updatePosition()
    }
    public func didShowKeyboard() {
        if msgHandler.currentPosition == .newEntry {
            msgHandler.currentPosition = .newEntryAndKeyboard
        } else if msgHandler.currentPosition == .regular {
            msgHandler.currentPosition = .regularAndKeyboard
        }
        updatePosition()
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
        updateStaticText()
        checkButtons()
        msgHandler.thoughtTitle = textView.text
    }
}
