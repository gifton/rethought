//
//  ThoughtDetailDelegate.swift
//  rethought
//
//  Created by Dev on 12/27/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DetailThoughtDelegate {
    var thought: Thought { get set }
    func returnHome()
    func userTapped(on entryID: String)
}

extension ThoughtDetailController: DetailThoughtDelegate {
    
    var thought: Thought {
        get {
            return detailThought ?? Thought()
        }
        set {
            let detailView = ThoughtDetailView(frame: ViewSize.FRAME, thought: newValue, delegate: self)
            self.view = detailView
            
            
        }
    }
    
    func userTapped(on entryID: String) {
        let entries = self.thought.entries
        let entry = entries.filter{ $0.id == entryID }.first ?? Entry.init(title: "Not available")
        let vc = EntryDetailController()
        vc.entry = entry
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
