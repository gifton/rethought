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

