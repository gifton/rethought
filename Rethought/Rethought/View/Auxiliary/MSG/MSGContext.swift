//
//  MSGContext.swift
//  Rethought
//
//  Created by Dev on 4/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

enum MSGContext {
    enum position {
        case regular, regularAndKeyboard, newEntry, newEntryAndKeyboard
    }
    enum size: CGFloat {
        case note      = 600.0
        case photo     = 586.00
        case link      = 360.0
        case recording = 465.0
        case regular   = 115.00
    }
    enum type {
        case note, photo, link, recording, none
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
    }
}

protocol MSGCenterHandlerDelegate {
    func updatePosition(to position: MSGContext.position)
    func updateSize(to size: MSGContext.size)
    var didStartNewEntry: Bool { get set }
}

class NewRecordingView: UIView, MSGSubView { var entryType: MSGContext.type = .recording }
class NewImageView: UIView, MSGSubView { var entryType: MSGContext.type = .photo }
class NewLinkView: UIView, MSGSubView { var entryType: MSGContext.type = .link }
class NewNoteView: UIView, MSGSubView { var entryType: MSGContext.type = .note }


protocol MSGCenterDelegate {
    func didTapEntry(ofType type: MSGContext.size, completion: ())
    func didSendMessage()
}
