
import UIKit

class MSGCenterHandler: NSObject {
    override init() {
        super.init()
        
    }
    
    // retrieve all buttons for disabling and enabling
    // set to internal var
    public func add(buttons: [MessageButton]) {
        entryButtons.forEach{ $0.isDisabled() }
        entryButtons.append(contentsOf: buttons)
    }
    
    // MARK: entry content
    private var entryButtons = [MessageButton]()
    // check if entry title has been added for button enabling
    var didAddEntryTitle: Bool = false
    var didAddEntryComponents: Bool {
        get {
            return false
        }
        set {
            if newValue == true && didAddEntryTitle == true {
                entryButtons.forEach { (btn) in
                    if (btn.messageButtonType == .send) { btn.doesEnable() }
                }
            }
        }
    }
    var didCompleteNewEntry: Bool = false{
        didSet {
            entryButtons.forEach { (btn) in
                if (btn.messageButtonType == .send) { btn.isDisabled() }
            }
        }
    }
    public var currentEntryType: EntryType = .none
    var didStartNewEntry: Bool {
        if currentEntryType == .none {
            return false
        }
        return true
    }
    
    // MARK: Thought content
    var didStartThought: Bool = false{
        didSet {
            entryButtons.forEach { (btn) in
                if (btn.messageButtonType == .send) { btn.doesEnable() }
            }
        }
    }
    var thoughtTitle: String?
    var thoughtIcon: ThoughtIcon = ThoughtIcon("🚦")
    var didCompleteThought: Bool = false{
        didSet {
            entryButtons.forEach { (btn) in
                if !(btn.messageButtonType == .send) { btn.doesEnable() } else { btn.isDisabled() }
            }
        }
    }
    // MARK: Positional variables
    var currentPosition: MSGContext.center.position = .regular
    //get currentSize of Message Center
    var currentSize: MSGContext.size {
        if !(didStartNewEntry) {
            return .regular
        } else {
            if currentEntryType != .none {
                return getSizeFrom(entryType: currentEntryType)
            }
            return .recording
        }
    }
    func getSizeFrom(entryType: EntryType) -> MSGContext.size {
        switch entryType {
        case .photo: return .photo
        case .link: return .link
        case .note: return .note
        case .recording: return .recording
        default: return .recording
        }
    }
    
    
    
    
    
    
    
    //text view variable placeholder
    public var textViewPlaceHolder: String {
        if (currentEntryType == .none) {
            if didCompleteThought {
                return "add an image or recording to your thought"
            }
            return "Give your thought a short title"
        }
        
        switch currentEntryType {
        case .note:
            return "Give your note a title"
        case .photo:
            return "Give your photo a title"
        case .link:
            return "Give your link a title"
        default:
            return "Give your recording a title"
        }
    }
    
    public var sendButtonTitle: NSAttributedString {
        let title = "send"
        
        
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : Device.font.mediumTitle(ofSize: .small),
                                                               NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}

//calculating views that should be in each position
extension MSGCenterHandler {
    //check if button belongs on screen at any given position
    public func isAvailable(btn: MessageButton) -> Bool {
        switch currentPosition {
        case .regular: return shouldBeInRegular(btn)
        default:       return shouldBeInEntry(btn)
        }
    }
    
    public func checkForEligibility(in superView: UIView) -> [Bool] {
        var checks = [Bool]()
        for view in superView.subviews {
            guard let btn: MessageButton = view as? MessageButton else {
                checks.append(true)
                continue
            }
            if currentPosition == .regular {
                if !(shouldBeInRegular(btn)) {
                    checks.append(false)
                    continue
                } else {
                    checks.append(true)
                    continue
                }
            } else {
                checks.append(true)
                continue
            }
        }
        
        print("checks count: \(checks.count) \n view count: \(superView.subviews.count)")
        return checks
    }
    
    private func shouldBeInRegular(_ buttonType: MessageButton) -> Bool {
        switch buttonType.messageButtonType {
        case.entry: return true
        case .send: return true
        }
    }
    
    private func shouldBeInEntry(_ buttonType: MessageButton) -> Bool { return true }
}

// textView delegate
extension MSGCenterHandler: UITextViewDelegate {
    //once editing begins on textView, set didStartThought: true
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        didStartThought = true
    }
    func textViewDidChange(_ textView: UITextView) {
        thoughtTitle = textView.attributedText.string
    }
}


class MSGCHandler: NSObject {
    override init() {
        super.init()
    }
    
    // MARK: entry content
    private var entryButtons = [MessageButton]()
    private var sendButton: MessageButton?
    private var entryView: MSGCenterEntryView?
    private var entryBuilders = [EntryBuilder]()
    
    // retrieve all buttons for disabling and enabling
    // set to internal var
    public func add(buttons: [MessageButton]) {
        
        entryButtons.forEach { (btn) in
            if btn.messageButtonType == MessageButtonType.send {
                self.sendButton = btn
            } else {
                btn.isDisabled()
            }
        }
        entryButtons.append(contentsOf: buttons)
    }
    
    //set entryView to private var
    public func add(entryView view: MSGCenterEntryView) {
        entryView = view
    }
    
    //when new entry is complete, send it hurr
    public func add<K: EntryBuilder>(entryBuilder builder: K) {
        retrieveBuilderType(entryBuilder: builder)
    }
    
    
    private func retrieveBuilderType<K: EntryBuilder>(entryBuilder builder: K) {
        switch builder.type {
        case .link:
            guard let link: LinkBuilder = builder as? LinkBuilder else {
                print("Unable to convert to link builder type")
                return
            }
            entryBuilders.append(link)
        case .photo:
            guard let photo: PhotoBuilder = builder as? PhotoBuilder else {
                print("Unable to convert to image builder type")
                return
            }
            entryBuilders.append(photo)
        case .note:
            guard let note: NoteBuilder = builder as? NoteBuilder else {
                print("Unable to convert to image builder type")
                return
            }
            entryBuilders.append(note)
       default:
            guard let recording: RecordingBuilder = builder as? RecordingBuilder else {
                print("Unable to convert to image builder type")
                return
            }
            entryBuilders.append(recording)
        }
    }

}

extension MSGCHandler: MSGCenterState {
    var isShowingEntry: Bool {
        if entryView != nil {
            return true
        }
        return false
    }
    
    var didSaveEntry: Bool {
        get {
            if entryBuilders.count > 0 {
                return true
            }
            return false
        }
    }
    
    var didStartEntry: Bool {
        guard let entryView = entryView else { return false }
        return entryView.minimumComponentsCompleted
    }
    
    var isTypingThought: Bool {
        return true
    }
    
    var didSaveThought: Bool {
        return true
    }
    
    var buttonAvailability: MSGContext.center.buttonAvailability {
        //if there is a thought saved, check if entry is being added
        if didSaveThought {
            // return all if entry is being added
            if didStartEntry {
                return .all
            // return only the buttons if a thought has been added but no other action has been made
            } else {
               return .entryButtons
            }
        // if a thought hasnt been added yet, see if one is currently being typed
        } else {
            //if a thought is being typed, the send button should be available
            if isTypingThought {
                return .send
            //if nothingis happening, our message center should have no available buttons
            } else {
                return .none
            }
        }
    }
    
    
}
