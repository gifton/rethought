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
class ThoughtPreviewSmall {
    let icon: String
    let lastEdited: Date
    var color: UIColor = .tileBackground
    let itemCount: String
    let thoughtID: String
    
    init(icon: String, lastEdited: Date, color: UIColor = .tileBackground, relatedThought: String, itemCount: Int) {
        self.icon = icon
        self.lastEdited = lastEdited
        self.thoughtID = relatedThought
        if color != .tileBackground {
            self.color = color
        }
        self.itemCount = "\(itemCount) items"
    }
}


//model for thought previews in dashboard (tableView cellForIndexPath: 0)
class ThoughtPreviewLarge {
    let icon: String
    let createdAt: String
    var color: UIColor = .tileBackground
    let entryCount: [String: Int]
    let thoughtID: String
    let title: String
    
    init(icon: String, createdAt: String, color: UIColor = .tileBackground, thoughtID: String, entryCount: [String: Int], title: String) {
        self.icon = icon
        self.createdAt = createdAt
        self.thoughtID = thoughtID
        self.entryCount = entryCount
        self.title = title
        if color != .tileBackground {
            self.color = color
        }
    }
    convenience init(_ empty: Bool? = true) {
        self.init(icon: "", createdAt: "", thoughtID: "", entryCount: ["String" : 0], title: "")
        if empty == true {
            print ("new thoughtPreviewLarge made empty")
        }
    }
}
