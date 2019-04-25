//
//  MessageCenterDelegate.swift
//  Rethought
//
//  Created by Dev on 4/19/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import UIKit

// viewController is responsible for talking to model to create thoughts / entries
// and tableview datasources and delegates
protocol MSGConnector {
    func save(withTitle title: String, withIcon: ThoughtIcon)
    func insert(entry: EntryBuilder)
    func isDoneEditing()
    func updateIcon(newIcon: ThoughtIcon)
    func keyboardWillShow()
    func keyboardWillHide()
    func entryWillShow(ofType type: EntryType)
}

// all types of buttons available
// used to find what items belong on the screen
enum MessageButtonType {
    case send, cancel, entry, open, close
}

enum MSGContext {
    enum position {
        case regular, ragularAndKeyboard, newEntry, newEntryAndKeyboard
    }
    enum size: CGFloat {
        case text      = 400.0
        case image     = 386.00
        case link      = 260.0
        case recording = 265.0
        case regular   = 115.00
    }
    enum type {
        case text, image, link, recording, none
    }
}

protocol MSGHandlerDelegate {
    func updatePosition(to position: MSGContext.position)
    func updateSize(to size: MSGContext.size)
    var didStartNewEntry: Bool { get set }
}

class MSGHandler: NSObject {
    override init() {
        super.init()
        
    }
    
    //variables
    var currentPosition: MSGContext.position = .regular
    var didStartNewEntry: Bool      = false
    var didCompleteNewentry: Bool = false
    var didCompleteThought: Bool    = false
    var thoughtTitle: String?
    var thoughtIcon: ThoughtIcon?
    var currentEntry: EntryContent?
    
    var currentNewEntryType: MSGContext.type = .none {
        didSet {
            if !(currentNewEntryType == .none) {
                self.didStartNewEntry = true
            }
        }
    }
    
    //get currentSize of Message Center
    var currentSize: MSGContext.size {
        if !(didStartNewEntry) {
            return .regular
        } else {
            if currentNewEntryType != .none {
                return getSizeFrom(entryType: currentNewEntryType)
            }
            return .recording
        }
    }
    
    func getSizeFrom(entryType: MSGContext.type) -> MSGContext.size {
        switch entryType {
        case .image: return .image
        case .link: return .link
        case .text: return .text
        case .recording: return .recording
        default: return .recording
        }
    }
    
    
}

//calculating views that should be in each position
extension MSGHandler {
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
