//
//  EntryPreview.swift
//  rethought
//
//  Created by Dev on 12/13/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//model for entry previews in dashboard (tableView cells (indexPath.row > 0))
struct EntryPreview {
    //standard objects
    let id         : String
    var ThoughtID  : String
    let date       : Date
    var thoughtIcon: ThoughtIcon
    var type       : EntryType
    
    //optional Values
    
    init(entry: Entry) {
        self.ThoughtID = entry.thought.id
        self.date = entry.date
        self.thoughtIcon = entry.thought.icon
        self.id = entry.id
        self.type = entry.type
    }
}
