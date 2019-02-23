//
//  DashboardThought.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//custom thought class
class DashboardThought {
    //minimum req's
    let icon: String
    let createdAt: String
    let entryCount: EntryCount
    let thoughtID: String
    let title: String
    
    init(icon: String, createdAt: String,  thoughtID: String, entryCount: EntryCount, title: String) {
        self.icon = icon
        self.createdAt = createdAt
        self.thoughtID = thoughtID
        self.entryCount = entryCount
        self.title = title
    }
}
