//
//  ThoughtBuilderController.swift
//  Rethought
//
//  Created by Dev on 4/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ConversationController: UIViewController {
    
    // Mark: Private vars
    private var model: ThoughtBuilderViewModel
    private var conversation: ConversationView!
    // Mark: public vars
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(withModel model: ThoughtBuilderViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        conversation = ConversationView(with: self)
        view = conversation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConversationController: MSGConnector {
    func insert<T>(entry: T) where T : EntryBuilder {
        // TODO:
        //switch type
        //guard to correct entryBuilder
        //call model func to insert intp context
    }
    
    func save(withTitle title: String, withIcon: ThoughtIcon) {
        // TODO:
        //call func from model to create thought, insert into context
        //reload table data on completion
        //tell view to return to regular size
    }
    
    func isDoneEditing() {
        //call update view to new size
        //alert tab bar to re appear
        tabBarController?.tabBar.isHidden = false
    }
    
    func updateIcon(newIcon: ThoughtIcon) {
        // TODO:
        //alert view model of change
        //reload table data
    }

    func entryWillShow(ofType type: MSGContext.size) {
        //tell view to update size
        tabBarController?.tabBar.isHidden = true
    }
}

