//
//  RecordingEntry+CoreDataClass.swift
//  Rethought-project
//
//  Created by Dev on 3/9/19.
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
    
    @NSManaged public var date: NSDate?
    @NSManaged public var detail: String?
    @NSManaged public var id: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var rawRecording: NSData?
    @NSManaged public var title: String?
    @NSManaged public var thought: Thought?
    
    
}

extension RecordingEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
