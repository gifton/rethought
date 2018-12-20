//
//  ThoughtPreviewSmall.swift
//  rethought
//
//  Created by Dev on 12/11/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtPreviewSmall {
    let icon: String
    let lastEdited: String
    var color: UIColor = .iconBackground
    let itemCount: String
    let thoughtID: String
    
    init(icon: String, lastEdited: String, color: UIColor = .iconBackground, relatedThought: String, itemCount: Int) {
        self.icon = icon
        self.lastEdited = lastEdited
        self.thoughtID = relatedThought
        if color != .iconBackground {
            self.color = color
        }
        self.itemCount = "\(itemCount) items"
    }
}
