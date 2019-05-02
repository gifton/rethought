
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
        case .cancel: return false
        case .close: return false
        case.entry: return true
        case .open: return false
        case .send: return true
        }
    }
    
    private func shouldBeInEntry(_ buttonType: MessageButton) -> Bool { return true }
}
