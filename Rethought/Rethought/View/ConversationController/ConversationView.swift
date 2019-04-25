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
          return CGRect(x: 0, y: frame.height - 200, width: Device.size.width, height: 115)
        }
        set {
            animateTo(position: newValue)
            tableEncapsulation.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        }
    }
    private var tableEncapsulation = UIView()
    //public objects
    public let conversationTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        
        return tv
    }()
    
    public var messageCenter: MSGCenter!

    
    init(with connector: MSGConnector) {
        super.init(frame: Device.size.frame)
        backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        messageCenter = MSGCenter(frame: msgFrame, connector: connector)
        setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {

        //add tableView
        tableEncapsulation.frame = CGRect(x: 0, y: 0, width: Device.size.width, height: msgFrame.origin.y)
        tableEncapsulation.backgroundColor = Device.colors.offWhite
        tableEncapsulation.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        
        print("HEight is: \(tableEncapsulation.frame.height)")
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
    }
    
}

extension ConversationView: ConversationDelegate {
    func updateViewTo(position: MSGContext.position) {
        //move subviews up to
    }
    
    
}
