//
//  MSGContext.swift
//  Rethought
//
//  Created by Dev on 4/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

// center info
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
    
    
}

// board info
extension MSGContext {
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


protocol MSGCenterDelegate {
    func didTapEntry(ofType type: MSGContext.size, completion: ())
    func didSendMessage()
}
