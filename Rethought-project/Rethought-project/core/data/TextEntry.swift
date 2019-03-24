//
//  TextEntry+CoreDataClass.swift
//  Rethought-project
//
//  Created by Dev on 3/9/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation

@objc(TextEntry)
public class TextEntry: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TextEntry> {
        return NSFetchRequest<TextEntry>(entityName: "TextEntry")
    }
    
    @NSManaged public var date: Date
    @NSManaged public var detail: String
    @NSManaged public var id: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var title: String
    @NSManaged public var thought: Thought
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    static func insert(in context: NSManagedObjectContext, title: String, detail: String, thought: Thought, location: CLLocation?) -> TextEntry {
        let entry: TextEntry = context.insertObject()
        
        //get ID number count from defaults, and increment
        let defaults = UserDefaults.standard
        let entryNum: Int = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        
        //set variables
        entry.id = "rt-pDB-E\(entryNum)"
        entry.date = Date()
        entry.detail = detail
        entry.title = title
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
    
    var preview: TextEntryPreview {
        get {
            return TextEntryPreview(self)
        }
    }
    
    func setFavorite(_ input: Bool) {
        self.isFavorite = input
    }
}


extension TextEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
