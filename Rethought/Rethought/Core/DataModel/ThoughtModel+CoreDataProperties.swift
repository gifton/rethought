//
//  ThoughtModel+CoreDataProperties.swift
//  rethought
//
//  Created by Dev on 2/3/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData


extension ThoughtModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThoughtModel> {
        return NSFetchRequest<ThoughtModel>(entityName: "ThoughtModel")
    }
    
    func setModel(thought: Thought) {
        self.createdAt = thought.createdAt as NSDate
        self.icon = thought.icon
        self.id = thought.ID
        self.title = thought.title
    }
    
    @NSManaged public var createdAt: NSDate
    @NSManaged public var icon: String
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var entryModels: NSSet?

}

// MARK: Generated accessors for entryModels
extension ThoughtModel {

    @objc(addEntryModelsObject:)
    @NSManaged public func addToEntryModels(_ value: EntryModel)

    @objc(removeEntryModelsObject:)
    @NSManaged public func removeFromEntryModels(_ value: EntryModel)

    @objc(addEntryModels:)
    @NSManaged public func addToEntryModels(_ values: NSSet)

    @objc(removeEntryModels:)
    @NSManaged public func removeFromEntryModels(_ values: NSSet)

}
