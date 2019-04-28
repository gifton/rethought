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
    
    private var tableEncapsulation = UIScrollView()
    public var conversationPresenter: ConversationPresenter!
    
    // public objects
    public var messageCenter: MSGCenter!
    
    init(with connector: MSGConnector) {
        super.init(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: Device.size.height - Device.size.tabBarHeight))
        backgroundColor = .white
        
        messageCenter = MSGCenter(frame: CGRect(x: 0, y: frame.height - 215, width: Device.size.width, height: 115), connector: connector)
        conversationPresenter = ConversationPresenter(tableEncapsulation, messageCenter, parent: self)
        setViews()
        
        print("height to' device: \(Device.size.height)")
        print("height to' view: \(frame.size.height)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        //add tableView
        addSubview(messageCenter)
        addSubview(tableEncapsulation)
    }
}
