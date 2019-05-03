//
//  MSGContext.swift
//  Rethought
//
//  Created by Dev on 4/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct MSGContext {
    enum center {
        enum position {
            case regular, regularAndKeyboard, newEntry, newEntryAndKeyboard
        }
        enum buttonAvailability {
            case all, none, send, entryButtons
        }
    }
    enum size: CGFloat {
        case note      = 600.0
        case photo     = 586.00
        case link      = 360.0
        case recording = 465.0
        case regular   = 115.00
    }
    
    enum board {
        enum viewType {
            case rethoughtIntro, newThought, newEntry, welcomeCard, rethoughtResponse
        }
        struct sizes {
            var welcomeCard = CGSize(width: 320, height: 169)
            var userResponsePaddingLeft: CGFloat = 65
            var userResponsePaddingRight: CGFloat = 15
            var rethoughtResponsePaddingRight: CGFloat = 65
            var rethoughtResponsePaddingLeft: CGFloat = 15
            var minimumConversationSize: CGSize = CGSize(width: Device.size.width, height: Device.size.height - Device.size.tabBarHeight - 115)
        }
        enum responseType: Int {
            case welcome            = 0
            case confirmThought     = 1
            case confirmThoughtIcon = 2
            case confirmEntry       = 3
        }
    }
}

protocol MSGCenterHandlerDelegate {
    func updatePosition(to position: MSGContext.center.position)
    func updateSize(to size: MSGContext.size)
    var didStartNewEntry: Bool { get set }
}

class NewRecordingView: UIView, MSGSubView { var entryType: EntryType = .recording }
class NewImageView: UIView, MSGSubView { var entryType: EntryType = .photo }
class NewLinkView: UIView, MSGSubView { var entryType: EntryType = .link }
class NewNoteView: UIView, MSGSubView { var entryType: EntryType = .note }


protocol MSGCenterDelegate {
    func didTapEntry(ofType type: MSGContext.size, completion: ())
    func didSendMessage()
}
