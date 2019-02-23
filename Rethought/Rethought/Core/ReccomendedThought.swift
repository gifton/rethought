//
//  ReccomendedThought.swift
//  rethought
//
//  Created by Dev on 1/22/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//Small cell with minimum req's for display
struct ReccomendedThought {
    init(_ thought: Thought) {
        self.icon = thought.icon
        self.daysSinceLastEdit = thought.lastEdited
        self.thoughtID = thought.id
        self.lastEntryType = thought.entries.first?.type ?? .text
    }
    
    let icon             : ThoughtIcon
    let daysSinceLastEdit: Date
    let thoughtID        : String
    let lastEntryType    : EntryType
}
