//
//  ThoughtPreviewSmall.swift
//  rethought
//
//  Created by Dev on 12/11/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//model for thought previews in dashboard (collectionview cells)

class ThoughtPreview {
    let icon      : ThoughtIcon
    let createdAt : String
    let entryCount: EntryCount
    let thoughtID : String
    let title     : String
    
    //param thought breakdown
    init(_ thought: Thought) {
        self.icon       = thought.icon
        self.createdAt  = "\(thought.lastEdited)"
        self.entryCount = thought.entryCount
        self.thoughtID  = thought.id
        self.title      = thought.title
    }
    
    convenience init(_ empty: Bool? = true) {
        self.init(Thought())
    }
}
