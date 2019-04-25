//
//  Thought+CoreDataProperties.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
import CoreLocation

@objc(Thought)
public class Thought: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thought> {
        return NSFetchRequest<Thought>(entityName: "Thought")
    }

    // MARK: Core Data properties
    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var icon: String
    @NSManaged public var id: String
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?

    // MARK: relationship
    @NSManaged public var entries: NSSet?

    // MARK: Computed properties
    var thoughtIcon: ThoughtIcon {
        return ThoughtIcon(icon)
    }
    
    var entryCount: EntryCount {
        guard let counts = entries else {
            return EntryCount(text: 0, images: 0, recordings: 0, links: 0)
        }
        var text = 0
        var image = 0
        var link = 0
        var recording = 0
        counts.forEach { (entry) in
            if let ent = entry as? Entry {
                switch ent.type {
                case "LINK":
                    link += 1
                case "NOTE":
                    text += 1
                case "RECORDING":
                    recording += 1
                case "IMAGE":
                    image += 1
                default:
                    print("unknown entry type")
                }
            }
        }
        return EntryCount(text: text, images: image, recordings: recording, links: link)
    }
    
    // search for most recent image entry image, convert to data and return
    public var recentImage: UIImage? {
        guard let entries = self.entries else {
            return nil
        }
        
        for ent in entries {
            
            if let entry = ent as? Entry {
                guard let rawImage = entry.rawImg else { return nil }
                return UIImage(data: rawImage)
            }
        }
        return nil
    }
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    //build thought components
    static func insert(in context: NSManagedObjectContext, title: String, icon: String, location: CLLocation?) -> Thought {
        //access defaults
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.thoughtID)
        
        let thought: Thought = context.insertObject()
        
        thought.date       = Date()
        thought.icon       = icon
        thought.title      = title
        thought.id         = "rt-pDB-T\(defaultCount)"
        
        //save location if available
        if let loc: CLLocation = location {
            thought.latitude  = loc.coordinate.latitude as NSNumber
            thought.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.thoughtID)
        
        return thought
    }
    
    static func insert(in context: NSManagedObjectContext, withPreview preview: ThoughtPreview) -> Thought {
        //access defaults
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.thoughtID)
        
        let thought: Thought = context.insertObject()
        
        thought.id   = "rt-pDB-T\(defaultCount)"
        thought.date = Date()
        thought.icon = preview.icon
        thought.title = preview.title
        
        //save location if available
        if let loc: CLLocation = preview.location {
            thought.latitude  = loc.coordinate.latitude as NSNumber
            thought.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.thoughtID)
        
        return thought
    }
    
}

// MARK: Generated accessors for entries
extension Thought {

    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: Entry)

    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: Entry)

    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)

    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)

}

extension Thought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}