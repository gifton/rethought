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
    
    //private objects
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
    
    //public objects
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

//all functions that animate elements
extension ConversationView {
    func animateTo(position: CGRect) {
        UIView.animate(withDuration: 0.25, animations: {
            self.tableEncapsulation.frame.size.height = position.origin.y
            self.messageCenter.frame = position
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 0 {
                self.frame.origin.y -= (keyboardSize.height)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.frame.origin.y != 0 {
            self.frame.origin.y = 0
        }
        messageCenter.didHideKeyboard()
    }
    
    public func updateViewTo(position: MSGContext.position) {
        //move subviews up to
    }
}

extension ConversationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resignFirstResponder()
        messageCenter.resignFirstResponder()
        messageCenter.textView.resignFirstResponder()
    }
}
