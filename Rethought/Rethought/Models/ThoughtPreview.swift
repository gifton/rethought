//
//  EntryPreview.swift
//  Rethought
//
//  Created by Dev on 4/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct ThoughtPreview {
    var title:       String
    var date:        Date
    var location:    CLLocation?
    var icon:        String
    var entryCount:  EntryCount
    var recentPhoto: UIImage?
    
    init(thought: Thought) {
        title = thought.title
        date = thought.date
        icon = thought.icon
        location = thought.location
        entryCount = thought.entryCount
        recentPhoto = thought.recentPhoto
    }
    
    init(title: String, icon: String, location: CLLocation?) {
        self.title = title
        self.location = location
        self.icon = icon
        date = Date()
        entryCount = EntryCount(text: 0, photos: 0, recordings: 0, links: 0)
    }
    
    init() {
        title = "Awesome Photos on wesat"
        date = Date()
        location = CLLocation()
        icon = "🔫"
        entryCount = EntryCount(text: 10, photos: 12, recordings: 4, links: 25)
    }
}
