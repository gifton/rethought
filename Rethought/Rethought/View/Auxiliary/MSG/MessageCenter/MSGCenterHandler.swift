
import UIKit

class MSGCenterHandler: NSObject {
    override init() {
        super.init()
        
    }
    
    // retrieve all buttons for disabling and enabling
    // set to internal var
    public func add(buttons: [MessageButton]) {
        entryButtons.append(contentsOf: buttons)
    }
    
    // MARK: entry content
    private var entryButtons = [MessageButton]()
    // check if entry title has been added for button enabling
    var didAddEntryTitle: Bool = false
    var didAddEntryComponents: Bool = false
    var didCompleteNewEntry: Bool = false
    public var currentEntryType: EntryType = .none
    var didStartNewEntry: Bool {
        if currentEntryType == .none {
            return false
        }
        return true
    }
    
    // MARK: Thought content
    var didStartThought: Bool = false
    var thoughtTitle: String?
    var thoughtIcon: ThoughtIcon?
    var didCompleteThought: Bool {
        return (thoughtTitle != nil && thoughtIcon != nil)
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
    
    //check state of buttons and dissable and enable as needed
    public func checkButtons() {
        // if thought is complete, enable all buttons except the send button
        if didCompleteThought {
            entryButtons.forEach { (msg) in
                if !(msg.messageButtonType == MessageButtonType.send) {
                    msg.doesEnable()
                }
            }
        } else {
            // if the user is still typing in there thought, or has added all the required parts of there thought, enable the send button
            if (didStartThought || didAddEntryComponents) {
                entryButtons.forEach { (msg) in
                    if (msg.messageButtonType == MessageButtonType.send) {
                        msg.doesEnable()
                    }
                }
                // if the user has not made a thought, or started typing one, set send button to disabled
            } else {
                entryButtons.forEach { (msg) in
                    if (msg.messageButtonType == MessageButtonType.send) {
                        msg.isDisabled()
                    }
                }
            }
        }
        //check if user has started typing there thought,
        if didStartThought || didAddEntryComponents {
            entryButtons.forEach{$0.doesEnable()}
        } else if didCompleteThought {
            entryButtons.forEach { (msg) in
                if !(msg.messageButtonType == MessageButtonType.send) {
                    msg.isDisabled()
                }
            }
        } else {
            entryButtons.forEach{$0.isDisabled()}
        }
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
        case .cancel: return false
        case .close: return false
        case.entry: return true
        case .open: return false
        case .send: return true
        }
    }
    
    private func shouldBeInEntry(_ buttonType: MessageButton) -> Bool { return true }
}
