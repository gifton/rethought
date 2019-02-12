//
//  ThoughtModel+CoreDataClass.swift
//  rethought
//
//  Created by Dev on 2/3/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ThoughtModel)
public class ThoughtModel: NSManagedObject {
    func setModel(thought: Thought) {
        self.createdAt = thought.createdAt as NSDate
        self.icon = thought.icon
        self.id = thought.ID
        self.title = thought.title
    }
}
