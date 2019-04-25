//
//  ThoughtBuilderViewe.swift
//  Rethought
//
//  Created by Dev on 4/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ConversationView: UIView {
    
    // private objects
    private var msgFrame: CGRect {
        get {
          return CGRect(x: 0, y: frame.height - 215, width: Device.size.width, height: 115)
        }
        set {
            animateTo(position: newValue)
            tableEncapsulation.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        }
    }
    private var tableEncapsulation = UIScrollView()
    private var keyboardIsShowing = false
    // public objects
    public var messageCenter: MSGCenter!
    
    init(with connector: MSGConnector) {
        super.init(frame: Device.size.frame)
        backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        messageCenter = MSGCenter(frame: msgFrame, connector: connector)
        setViews()
        
        print("height o device: \(Device.size.height)")
        print("height o view: \(frame.size.height)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {

        //add tableView
        tableEncapsulation.frame = CGRect(x: 0, y: 0, width: Device.size.width, height: msgFrame.origin.y)
        tableEncapsulation.contentSize = CGSize(width: Device.size.width, height: msgFrame.origin.y + 1)
        tableEncapsulation.backgroundColor = Device.colors.offWhite
        tableEncapsulation.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        tableEncapsulation.delegate = self
        
        addSubview(messageCenter)
        addSubview(tableEncapsulation)
    }
}

// all functions that animate elements
extension ConversationView {
    private func animateTo(position: CGRect) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 8.5, options: .curveEaseInOut, animations: {
            self.tableEncapsulation.frame.size.height = position.origin.y
            self.messageCenter.frame = position
        }) { _ in
            //
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if messageCenter.frame == msgFrame {
                self.frame.origin.y -= (keyboardSize.height)
            }
        }
        keyboardIsShowing = true
        messageCenter.didShowKeyboard()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
            messageCenter.didHideKeyboard()
            keyboardIsShowing = false
            return
        }
        keyboardIsShowing = false
    }
    
    public func updateViewTo(position: MSGContext.size) {
        // get rawValue
        let height = position.rawValue
        // move subviews up to
        if !(messageCenter.frame.height == height) {
            msgFrame = CGRect(x: 0, y: frame.height - height, width: frame.width, height: height)
        }
        
    }
    
}

extension ConversationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if keyboardIsShowing {
            resignFirstResponder()
            messageCenter.resignFirstResponder()
            messageCenter.textView.resignFirstResponder()
        } else {
            animateTo(position: msgFrame)
            messageCenter.removeEntryView()
        }
    }
    
    
}
