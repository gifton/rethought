//
//  DashboardThought.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

//custom thought class
struct ThoughtPreview {
    //minimum req's
    let icon: ThoughtIcon
    let createdAt: Date
    let entryCount: EntryCount
    let thoughtID: String
    let title: String
    let location: CLLocation
    
    init(thought: Thought) {
        self.icon       = thought.icon
        self.createdAt  = thought.date
        self.entryCount = thought.entryCount
        self.thoughtID  = thought.id
        self.title      = thought.title
        self.location   = thought.location ?? CLLocation()
    }
}
