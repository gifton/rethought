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
    var isKeyboardShowing: Bool = false
    private struct ConversationPosition{
        var msgFrame: CGRect
        var viewFrame: CGRect
        
        init(msgFrame: CGRect, viewFrame: CGRect) {
            self.msgFrame = msgFrame
            self.viewFrame = viewFrame
            
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
        //layout newobjects, frame, color, rounded edges, etc
        msgCenter.frame = CGRect(x: 0, y: parent.frame.height - regularMessageCenterHeight, width: parent.frame.width, height: regularMessageCenterHeight)
        view.frame = CGRect(x: 0, y: 0, width: parent.frame.width, height: (parent.frame.height - msgCenter.frame.height))
        
        view.contentSize = CGSize(width: Device.size.width, height: view.frame.height + CGFloat(1.0))
        view.backgroundColor = Device.colors.offWhite
        view.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        view.delegate = self
        
        UIView.animate(withDuration: 0.25) {
            self.msgCenter.alpha = 1.0
            self.view.alpha = 1.0
        }
    }
    
}

extension ConversationPresenter {
    func didTapOn(entry type: MSGContext.size) {
        //get height calculation
        let height = type.rawValue
        let msgCenterFrame = CGRect(x: 0, y: parent.frame.height - height, width: parent.frame.width, height: height)
        //calculate frames for msgcenter and table
        let viewFrame = CGRect(x: 0, y: 0, width: parent.frame.width, height: parent.frame.height - height)
        //animate to frame
        animateTo(position: ConversationPosition(msgFrame: msgCenterFrame, viewFrame: viewFrame))
    }
    
    private func animateTo(position: ConversationPosition) {
        //uiview animate to position
        UIView.animate(withDuration: 0.25) {
            self.msgCenter.frame = position.msgFrame
            self.view.frame = position.viewFrame
        }
        view.roundCorners([.bottomLeft, .bottomRight], radius: 20)
    }
    
    private func animateForKeyboard(upwards: Bool, toHeight height: CGFloat) {
        if upwards {
            UIView.animate(withDuration: 0.25) {
                //move entire view
                self.parent.frame.origin.y -= height
                //change tableView to correct height
                self.view.frame.size.height -= height
            }
        } else {
            UIView.animate(withDuration: 0.25) {
                //move entire view
                self.parent.frame.origin.y += height
                //change tableView to correct height
                self.view.frame.size.height += height
            }
        }
        view.roundCorners([.bottomLeft, .bottomRight], radius: 20)
    }
    
    public func keyboardWillShow(keyboardRect rect: CGRect) {
            print("keyboard showing in presentation handler")
        print(msgCenter.frame)
        if msgCenter.frame.height == regularMessageCenterHeight {
            print("animating to rect: \(rect.height)")
            animateForKeyboard(upwards: true, toHeight: rect.height)
        } else {
            print("animating upwards a smidge")
            self.msgCenter.frame.origin.y -= 25
        }
        msgCenter.didShowKeyboard()
        isKeyboardShowing = true
    }
    
    public func keyboardWillHide(keyboardRect size: CGRect) {
        
        if msgCenter.frame.height == regularMessageCenterHeight {
            animateForKeyboard(upwards: false, toHeight: size.height)
        } else {
            UIView.animate(withDuration: 0.25) {
                self.msgCenter.frame.origin.y += 25
            }
        }
        msgCenter.didHideKeyboard()
        isKeyboardShowing = false
    }
}

extension ConversationPresenter: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
        if isKeyboardShowing {
            parent.resignFirstResponder()
            msgCenter.resignFirstResponder()
            msgCenter.textView.resignFirstResponder()
            let msgFrame = CGRect(x: 0, y: parent.frame.height - regularMessageCenterHeight, width: parent.frame.width, height: regularMessageCenterHeight)
            let viewFrame = CGRect(x: 0, y: 0, width: parent.frame.width, height: (parent.frame.height - msgFrame.height))
            animateTo(position: ConversationPosition(msgFrame: msgFrame, viewFrame: viewFrame))
        } else {
            if !(msgCenter.frame.height == regularMessageCenterHeight) {
                msgCenter.removeEntryView()
                let msgFrame = CGRect(x: 0, y: parent.frame.height - regularMessageCenterHeight, width: parent.frame.width, height: regularMessageCenterHeight)
                let viewFrame = CGRect(x: 0, y: 0, width: parent.frame.width, height: (parent.frame.height - msgCenter.frame.height))
                animateTo(position: ConversationPosition(msgFrame: msgFrame, viewFrame: viewFrame))
            }
        }
    }
}
