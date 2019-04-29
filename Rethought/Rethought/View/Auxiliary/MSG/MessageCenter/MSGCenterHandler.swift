
import UIKit

class MSGCenterHandler: NSObject {
    override init() {
        super.init()
        
    }
    
    //variables
    var currentPosition: MSGContext.position = .regular
    
    var didStartNewEntry: Bool {
        if currentEntryType == .none {
            return false
        }
        return true
    }
    var didCompleteNewentry: Bool = false
    var didCompleteThought: Bool {
        return (thoughtTitle != nil && thoughtIcon != nil)
    }
    var didStartThought: Bool = false
    var thoughtTitle: String?
    var thoughtIcon: ThoughtIcon?
    var currentEntry: EntryContent?
    
    public var currentEntryType: MSGContext.type = .none
    
    //return entrytype, just in a different enum type
    public var entryType: EntryType? {
        switch currentEntryType {
        case .photo: return .photo
        case .link: return .link
        case .recording: return .recording
        case .note: return .note
        default:
            return nil
        }
    }
    
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
    
    func getSizeFrom(entryType: MSGContext.type) -> MSGContext.size {
        switch entryType {
        case .photo: return .photo
        case .link: return .link
        case .note: return .note
        case .recording: return .recording
        default: return .recording
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
