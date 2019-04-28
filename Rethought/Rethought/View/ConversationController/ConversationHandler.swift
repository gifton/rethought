//
//  ConversationHandler.swift
//  Rethought
//
//  Created by Dev on 4/25/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

open class ConversationPresenter: NSObject {
    
    let regularMessageCenterHeight: CGFloat = 115.0
    var isShowingEntry: Bool = false
    private struct ConversationPosition{
        var msgFrame: CGRect
        var viewFrame: CGRect
        
        init(msgFrame: CGRect, viewFrame: CGRect) {
            self.msgFrame = msgFrame
            self.viewFrame = viewFrame
            
        }
        static var barHeight = Device.size.tabBarHeight
        static var max = Device.size.self
        static var msg = MSGContext.size.self
        static func standard() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (barHeight + msg.regular.rawValue), width: max.width, height: msg.regular.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (barHeight + msg.regular.rawValue)))
        }
        static func link() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.link.rawValue), width: max.width, height: msg.link.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.link.rawValue)))
        }
        static func recording() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.recording.rawValue), width: max.width, height: msg.recording.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.recording.rawValue)))
        }
        static func note() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.note.rawValue), width: max.width, height: msg.note.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.note.rawValue)))
        }
        static func photo() -> ConversationPosition {
            return ConversationPosition(msgFrame: CGRect(x: 0, y: max.height - (msg.photo.rawValue), width: max.width, height: msg.photo.rawValue),
                                        viewFrame: CGRect(x: 0, y: 0, width: max.width, height: max.height - (msg.photo.rawValue)))
        }
    }
    
    var parent: ConversationView
    var msgCenter: MSGCenter
    var view: UIScrollView
    init(_ view: UIScrollView, _ msgCenter: MSGCenter, parent: ConversationView) {
        self.view = view
        self.msgCenter = msgCenter
        self.parent = parent
        super.init()
        
        setupInitialConversation()
    }
    
    
    private func setupInitialConversation() {
        //sert delegates
        msgCenter.delegate = self
        view.delegate = self
        //layout newobjects, frame, color, rounded edges, etc
        msgCenter.frame = CGRect(x: 0, y: parent.frame.height - regularMessageCenterHeight, width: parent.frame.width, height: regularMessageCenterHeight)
        view.frame = CGRect(x: 0, y: 0, width: parent.frame.width, height: (parent.frame.height - msgCenter.frame.height))
        
        view.contentSize = CGSize(width: Device.size.width, height: 1000)
        view.backgroundColor = Device.colors.offWhite
        view.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        
        UIView.animate(withDuration: 0.25) {
            self.msgCenter.alpha = 1.0
            self.view.alpha = 1.0
        }
    }
    
}

extension ConversationPresenter {
    private func animateTo(position: ConversationPosition) {
        //uiview animate to position
        UIView.animate(withDuration: 0.45) {
            self.msgCenter.frame = position.msgFrame
            self.view.frame = position.viewFrame
        }
        view.roundCorners([.bottomLeft, .bottomRight], radius: 20)
    }
}

extension ConversationPresenter: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        msgCenter.textView.resignFirstResponder()
        if msgCenter.isShowingEntry {
            msgCenter.removeEntryView()
            animateTo(position: .standard())
        }
        
    }
}

extension ConversationPresenter: MSGDelegate {
    func didTapEntry(ofType type: MSGContext.size, completion: ()) {
        
        // if entry view is currently not showing
        // animate to correct entry view
        if !(msgCenter.isShowingEntry) {
            
            switch type {
            case .link: animateTo(position: .link())
            case .photo: animateTo(position: .photo())
            case .note: animateTo(position: .note())
            case .recording: animateTo(position: .recording())
            default: animateTo(position: .standard())
            }
            
            isShowingEntry = true
            completion
        
        // if msgCenter view is equal to entry tapped
        // assume entry is the same, and close the entry and set regular view
        } else if msgCenter.frame.size.height == type.rawValue {
            
            
            // hide entry
            animateTo(position: .standard())
            msgCenter.removeEntryView()
            
        // if entry view is currently showing
        // animate to correct entry view
        } else {
            
            switch type {
            case .link: animateTo(position: .link())
            case .photo: animateTo(position: .photo())
            case .note: animateTo(position: .note())
            case .recording: animateTo(position: .recording())
            default: animateTo(position: .standard())
            }
            
            isShowingEntry = true
            completion
        }
    }
    
    func didSendMessage() {
        //move to regular height again
        animateTo(position: .standard())
    }
    
    
    private func getEntryFromSize(_ size: MSGContext.size = MSGContext.size.regular) -> MSGContext.type {
        if size == .regular {
            switch msgCenter.frame.height {
            case MSGContext.size.link.rawValue: return .link
            case MSGContext.size.recording.rawValue: return .recording
            case MSGContext.size.photo.rawValue: return .photo
            case MSGContext.size.note.rawValue: return .note
            default: return .none
            }
        }
        
        switch size {
        case MSGContext.size.link: return .link
        case MSGContext.size.recording: return .recording
        case MSGContext.size.photo: return .photo
        case MSGContext.size.note: return .note
        default: return .none
        }
    }
}

