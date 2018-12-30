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
    let lastEdited: String
    var color: UIColor = .tileBackground
    let itemCount: String
    let thoughtID: String
    
    init(icon: String, lastEdited: String, color: UIColor = .tileBackground, relatedThought: String, itemCount: Int) {
        self.icon = icon
        self.lastEdited = lastEdited
        self.thoughtID = relatedThought
        if color != .tileBackground {
            self.color = color
        }
        self.itemCount = "\(itemCount) items"
    }
}
