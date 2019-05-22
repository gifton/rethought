//
//  RecordingEntry+CoreDataProperties.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData

@objc(RecordingEntry)
public class RecordingEntry: NSManagedObject {


    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordingEntry> {
        return NSFetchRequest<RecordingEntry>(entityName: "RecordingEntry")
    }

    // MARK: Objects
    @NSManaged public var rawRecording: Data
    @NSManaged public var detail: String
    
    // MARK: Relationship
    @NSManaged public var entry: Entry
    
    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: RecordingBuilder) -> RecordingEntry {
        guard let entry = builder.entry else {
            print("there was a problem verifying the entry identity")
            return RecordingEntry(context: context)
        }
        // set variables from builder
        let rec: RecordingEntry = context.insertObject()
        rec.detail = builder.userDetail
        rec.entry = entry
//        rec.rawRecording = 
        
        return rec
    }

}

extension RecordingEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
