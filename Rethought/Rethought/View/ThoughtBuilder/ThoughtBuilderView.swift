//
//  ThoughtBuilderViewe.swift
//  Rethought
//
//  Created by Dev on 4/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtBuilderView: UIView {
    
    //private objects
    var messageCenterFrame: CGRect {
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
    public var messageCenter: MessageCenter?
    
    init() {
        super.init(frame: Device.size.frame)
        backgroundColor = .white
        setViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        
        // message center
        messageCenter = MessageCenter(frame: messageCenterFrame, connector: self)
        

        //add tableView
        tableEncapsulation.frame = CGRect(x: 0, y: 0, width: Device.size.width, height: messageCenterFrame.origin.y)
        tableEncapsulation.backgroundColor = Device.colors.offWhite
        tableEncapsulation.roundCorners([.bottomLeft, .bottomRight], radius: 20)
        
        print("HEight is: \(tableEncapsulation.frame.height)")
        addSubview(messageCenter!)
        addSubview(tableEncapsulation)
    }
}


extension ThoughtBuilderView: MessageCenterConnector {
    func tappedOn(entry type: EntryType, completion: () -> Void) {
        if self.frame.origin.y != 0 {
            completion()
            return
        }
        
        messageCenterFrame = CGRect(x: messageCenterFrame.origin.x,
                                    y: messageCenterFrame.origin.y - 200,
                                    width: messageCenterFrame.width,
                                    height: messageCenterFrame.height + 200)
        completion()
    }
    
    func tappedSave(withTitle title: String, withIcon: ThoughtIcon) {
        print("saved!")
    }
    
    func isDoneEditing() {
        print("is done editing in view")
        messageCenterFrame = CGRect(x: 0, y: frame.height - 200, width: Device.size.width, height: 115)
        messageCenter?.isDisplayingInputView = false
    }
}

//all functions that animate elements
extension ThoughtBuilderView {
    func animateTo(position: CGRect) {
        guard let msgCenter = self.messageCenter else { return }
        UIView.animate(withDuration: 0.25, animations: {
            self.tableEncapsulation.frame.size.height = position.origin.y
            msgCenter.frame = position
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
