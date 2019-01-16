//
//  DashboardThought.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardThought {
    let icon: String
    let createdAt: String
    let entryCount: [String: Int]
    let thoughtID: String
    let title: String
    
    init(icon: String, createdAt: String,  thoughtID: String, entryCount: [String: Int], title: String) {
        self.icon = icon
        self.createdAt = createdAt
        self.thoughtID = thoughtID
        self.entryCount = entryCount
        self.title = title
    }
    
    convenience init(thought: Thought) {
        func buildRecent(date: Date) -> String {
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .none
                formatter.timeStyle = .short
                formatter.doesRelativeDateFormatting = true
                formatter.formattingContext = .standalone
                return formatter
            }()
            
            return String(describing: dateFormatter.string(from: date))
        }
        self.init(icon: thought.icon, createdAt: buildRecent(date: thought.date), thoughtID: thought.ID, entryCount: thought.entryCount, title: thought.title)
    }
    convenience init(_ empty: Bool? = true) {
        self.init(icon: "", createdAt: "", thoughtID: "", entryCount: ["String" : 0], title: "")
        if empty == true {
            print ("new thoughtPreviewLarge made empty")
        }
    }
}
