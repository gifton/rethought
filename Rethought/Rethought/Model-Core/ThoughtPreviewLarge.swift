//
//  ThoughtPreviewLarge.swift
//  rethought
//
//  Created by Dev on 12/11/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//model for thought previews in dashboard (tableView cellForIndexPath: 0)
class ThoughtPreviewLarge {
    let icon: String
    let createdAt: String
    var color: UIColor = .iconBackground
    let entryCount: [String: Int]
    let thoughtID: String
    let title: String
    
    init(icon: String, createdAt: String, color: UIColor = .iconBackground, relatedThought: String, entryCount: [String: Int], title: String) {
        self.icon = icon
        self.createdAt = createdAt
        self.thoughtID = relatedThought
        self.entryCount = entryCount
        self.title = title
        if color != .iconBackground {
            self.color = color
        }
    }
    convenience init(_ empty: Bool? = true) {
        self.init(icon: "", createdAt: "", relatedThought: "", entryCount: ["String" : 0], title: "")
        if empty == true {
            print ("new thoughtPreviewLarge made empty")
        }
    }
}
