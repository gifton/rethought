//
//  ThoughtBuilderViewe.swift
//  Rethought
//
//  Created by Dev on 4/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

// Wrapper for MSGCenter and ConversationScrollView
class ConversationView: UIView {
    
    public var tableEncapsulation: MSGBoard!
    
    // public objects
    public var msgCenter: MSGCenter!
    public var conversationPresenter: ConversationPresenter!
    
    init(with connector: MSGConnector) {
        super.init(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - Device.size.tabBarHeight))
        backgroundColor = .white
        
        // initiate message center with injected params
        msgCenter = MSGCenter(frame: CGRect(x: 0, y: frame.height - 215, width: Device.size.width, height: 115), connector: connector)
        tableEncapsulation = MSGBoard(frame: CGRect(x: 0, y: 0, width: frame.width, height: (frame.height - msgCenter.frame.height)))
        
        // initiate presenter with variables
        conversationPresenter = ConversationPresenter(tableEncapsulation, msgCenter, parent: self)
        conversationPresenter.msgDely = connector
        setViews()
        
        print("height o' device: \(Device.size.height)")
        print("height o' view: \(frame.size.height)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        //add scroll view and msgcenter after theyve been connected to presenter
        addSubview(msgCenter)
        addSubview(tableEncapsulation)
    }
}
