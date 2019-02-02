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

    @NSManaged public var date: Date?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var entryModel: NSSet?

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
