//
//  Entry+CoreDataProperties.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation
import UIKit

@objc(Entry)
public class Entry: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    // MARK: Core Data properties
    @NSManaged public var id: String
    @NSManaged public var date: Date
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var type: String
    
    // MARK: Relationships
    @NSManaged public var thought: Thought
    @NSManaged public var text: TextEntry?
    @NSManaged public var photo: PhotoEntry?
    @NSManaged public var recording: RecordingEntry?
    @NSManaged public var link: LinkEntry?
    
    // MARK: Computed properties
    public var rawPhoto: Data? {
        if let rawimg = photo?.rawPhoto {
            return rawimg
        } else {
            return nil
        }
    }
    
    static func insertEntry<K: EntryBuilder>(into context: NSManagedObjectContext, location: CLLocation?, payload: K) -> Entry {
        //init defaults
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        let entry: Entry = context.insertObject()
        
        entry.type = "\(payload.type)"
        
        sort(payload: payload, for: context)
        
        //save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
    
    private static func sort<T: EntryBuilder>(payload: T, for context: NSManagedObjectContext) {
        switch payload.type {
        case .photo:
            guard let photoBuilder: PhotoBuilder = payload as? PhotoBuilder else { return }
            let _ = PhotoEntry.insert(into: context, builder: photoBuilder)
        case .link:
            guard let linkBuilder: LinkBuilder = payload as? LinkBuilder else { return }
            let _ = LinkEntry.insert(into: context, builder: linkBuilder)
        case .note:
            guard let textBuilder: TextBuilder = payload as? TextBuilder else { return }
            let _ = TextEntry.insert(into: context, builder: textBuilder)
        case .recording:
            guard let linkBuilder: LinkBuilder = payload as? LinkBuilder else { return }
            let _ = LinkEntry.insert(into: context, builder: linkBuilder)
        default:
            break
        }
    }
}

extension Entry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}

