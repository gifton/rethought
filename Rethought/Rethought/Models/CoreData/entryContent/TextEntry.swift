//
//  TextEntry+CoreDataProperties.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TextEntry)
public class TextEntry: NSManagedObject {
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TextEntry> {
        return NSFetchRequest<TextEntry>(entityName: "TextEntry")
    }
    
    // MARK: Objects
    @NSManaged public var title: String?
    @NSManaged public var detail: String
    
    // MARK: Relationship
    @NSManaged public var entry: Entry

    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: TextBuilder) -> TextEntry {
        
        // set variables from builder
        let text: TextEntry = context.insertObject()
        text.detail = builder.detail
        text.title = builder.title
        text.entry = builder.entry
        
        return text
    }
}

extension TextEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
