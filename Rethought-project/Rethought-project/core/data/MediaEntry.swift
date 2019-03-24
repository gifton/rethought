//
//  MediaEntry+CoreDataClass.swift
//  Rethought-project
//
//  Created by Dev on 3/9/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation
import UIKit

@objc(MediaEntry)
public class MediaEntry: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaEntry> {
        return NSFetchRequest<MediaEntry>(entityName: "MediaEntry")
    }
    
    @NSManaged public var date: Date
    @NSManaged public var detail: String
    @NSManaged public var id: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var rawMedia: Data
    @NSManaged public var thought: Thought
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    public var media: UIImage {
        get {
            guard let img: UIImage = UIImage(data: rawMedia) else { return UIImage(named: "imagePlaceholder")!}
            return img
        }
    }
    
    static func insert(in context: NSManagedObjectContext, image: UIImage, detail: String, thought: Thought, location: CLLocation?) -> MediaEntry {
        let entry: MediaEntry = context.insertObject()
        
        //get ID number count from defaults, and increment
        let defaults = UserDefaults.standard
        let entryNum: Int = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        guard let imgData = image.pngData() else {
            print("unable to decode image data, handing an empty entry")
            return entry
        }
        
        //set variables
        entry.id = "rt-pDB-E\(entryNum)"
        entry.date = Date()
        entry.detail = detail
        entry.rawMedia = imgData
        entry.isFavorite = false
        entry.thought = thought
        
        //save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(entryNum + 1, forKey: UserDefaults.Keys.entryID)
        return entry
    }
    
    var preview: MediaEntryPreview {
        get {
            return MediaEntryPreview(self)
        }
    }
}

extension MediaEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
