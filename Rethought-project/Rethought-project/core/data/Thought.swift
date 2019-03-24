//
//  Thought+CoreDataClass.swift
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


@objc(Thought)
public class Thought: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thought> {
        return NSFetchRequest<Thought>(entityName: "Thought")
    }
    
    @NSManaged public var date:       Date
    @NSManaged public var icon:       String
    @NSManaged public var id:         String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var latitude:   NSNumber?
    @NSManaged public var longitude:  NSNumber?
    @NSManaged public var title:      String
    
    // MARK: relationships
    @NSManaged public var links:      Set<LinkEntry>
    @NSManaged public var media:      Set<MediaEntry>
    @NSManaged public var recordings: Set<RecordingEntry>
    @NSManaged public var text:       Set<TextEntry>
    
    //return all entries
    var entries: [Entry] {
        get {
            var entries = [Entry]()
            for link in links {
                let preview = LinkEntryPreview(link)
                entries.append(preview)
            }
            for item in media {
                let preview = MediaEntryPreview(item)
                entries.append(preview)
            }
            for item in text {
                let preview = TextEntryPreview(item)
                entries.append(preview)
            }
            
            return entries
        }
    }
    
    //return most recent image if any
    var recentImage: UIImage? {
        get {
            let recent = media.first
            return recent?.media
        }
    }
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    var entryCount: EntryCount {
        get {
            return EntryCount(text: text.count, images: media.count, recordings: recordings.count, links: links.count)
        }
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
        thought.isFavorite = false
        
        //save location if available
        if let loc: CLLocation = location {
            thought.latitude  = loc.coordinate.latitude as NSNumber
            thought.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.thoughtID)
        
        return thought
    }
    
    //return object used for scrollViews and previewing thought
    var preview: ThoughtPreview {
        get {
            return ThoughtPreview(thought: self)
        }
    }
    
    func setFavorite(_ input: Bool) {
        self.isFavorite = input
    }
}

extension Thought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
