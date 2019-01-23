//
//  ReccomendedThought.swift
//  rethought
//
//  Created by Dev on 1/22/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct ReccomendedThought {
    init(_ thought: Thought) {
        self.icon = ThoughtIcon(thought.icon)
        self.daysSinceLastEdit = thought.lastEdited
        self.thoughtID = thought.ID
        self.lastEntryType = thought.entries.last?.type ?? .text
    }
    
    let icon             : ThoughtIcon
    let daysSinceLastEdit: Date
    let thoughtID        : String
    let lastEntryType    : Entry.EntryType
}
