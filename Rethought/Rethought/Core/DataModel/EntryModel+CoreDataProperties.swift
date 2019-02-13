//
//  EntryModel+CoreDataProperties.swift
//  rethought
//
//  Created by Dev on 2/10/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData


extension EntryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntryModel> {
        return NSFetchRequest<EntryModel>(entityName: "EntryModel")
    }

    @NSManaged public var detail: String
    @NSManaged public var entryDate: NSDate
    @NSManaged public var entryID: String
    @NSManaged public var entryTitle: String?
    @NSManaged public var image: Data?
    @NSManaged public var link: String?
    @NSManaged public var linkImage: Data?
    @NSManaged public var linkTitle: String?
    @NSManaged public var recording: Data?
    @NSManaged public var type: String
    @NSManaged public var thoughtModel: ThoughtModel

}
