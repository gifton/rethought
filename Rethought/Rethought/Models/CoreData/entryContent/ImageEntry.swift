//
//  ImageEntry+CoreDataProperties.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ImageEntry)
public class ImageEntry: NSManagedObject {


    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntry> {
        return NSFetchRequest<ImageEntry>(entityName: "ImageEntry")
    }
    
    
    // MARK: Objects
    @NSManaged public var rawImage: Data
    @NSManaged public var detail: String?
    
    // MARK: Relationship
    @NSManaged public var entry: Entry
    
    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: ImageBuilder) -> ImageEntry {
        
        let img: ImageEntry = context.insertObject()
        img.detail = builder.userDetail
        img.entry = builder.entry
        img.rawImage = builder.image
        
        return img
    }
}

extension ImageEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
