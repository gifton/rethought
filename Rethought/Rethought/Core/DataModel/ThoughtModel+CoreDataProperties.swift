//
//  ThoughtModel+CoreDataProperties.swift
//  rethought
//
//  Created by Dev on 2/10/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData


extension ThoughtModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThoughtModel> {
        return NSFetchRequest<ThoughtModel>(entityName: "ThoughtModel")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var entryModels: NSOrderedSet?

}

// MARK: Generated accessors for entryModels
extension ThoughtModel {

    @objc(insertObject:inEntryModelsAtIndex:)
    @NSManaged public func insertIntoEntryModels(_ value: EntryModel, at idx: Int)

    @objc(removeObjectFromEntryModelsAtIndex:)
    @NSManaged public func removeFromEntryModels(at idx: Int)

    @objc(insertEntryModels:atIndexes:)
    @NSManaged public func insertIntoEntryModels(_ values: [EntryModel], at indexes: NSIndexSet)

    @objc(removeEntryModelsAtIndexes:)
    @NSManaged public func removeFromEntryModels(at indexes: NSIndexSet)

    @objc(replaceObjectInEntryModelsAtIndex:withObject:)
    @NSManaged public func replaceEntryModels(at idx: Int, with value: EntryModel)

    @objc(replaceEntryModelsAtIndexes:withEntryModels:)
    @NSManaged public func replaceEntryModels(at indexes: NSIndexSet, with values: [EntryModel])

    @objc(addEntryModelsObject:)
    @NSManaged public func addToEntryModels(_ value: EntryModel)

    @objc(removeEntryModelsObject:)
    @NSManaged public func removeFromEntryModels(_ value: EntryModel)

    @objc(addEntryModels:)
    @NSManaged public func addToEntryModels(_ values: NSOrderedSet)

    @objc(removeEntryModels:)
    @NSManaged public func removeFromEntryModels(_ values: NSOrderedSet)

}
