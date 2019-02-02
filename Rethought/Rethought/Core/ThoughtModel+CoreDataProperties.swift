//
//  ThoughtModel+CoreDataProperties.swift
//  rethought
//
//  Created by Dev on 2/1/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData


extension ThoughtModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThoughtModel> {
        return NSFetchRequest<ThoughtModel>(entityName: "ThoughtModel")
    }
    
    convenience init(moc: NSManagedObjectContext, thought: Thought) {
        self.init(context: moc)
        self.title = thought.title
        self.icon = thought.icon
        self.id = thought.ID
        
    }

    @NSManaged public var title: String?
    @NSManaged public var icon: String?
    @NSManaged public var entryModel: NSSet?
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
}

// MARK: Generated accessors for entryModel
extension ThoughtModel {

    @objc(addEntryModelObject:)
    @NSManaged public func addToEntryModel(_ value: EntryModel)

    @objc(removeEntryModelObject:)
    @NSManaged public func removeFromEntryModel(_ value: EntryModel)

    @objc(addEntryModel:)
    @NSManaged public func addToEntryModel(_ values: NSSet)

    @objc(removeEntryModel:)
    @NSManaged public func removeFromEntryModel(_ values: NSSet)

}
