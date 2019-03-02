//
//  ThoughtModel.swift
//  rethought
//
//  Created by Dev on 2/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

@objc(Thought)
public class Thought: NSManagedObject {
    @NSManaged fileprivate(set) var date:      Date
    @NSManaged fileprivate(set) var id:        String
    @NSManaged fileprivate(set) var title:     String
    @NSManaged fileprivate(set) var rawIcon:   String
    @NSManaged fileprivate(set) var latitude:  NSNumber?
    @NSManaged fileprivate(set) var longitude: NSNumber?
    
    @NSManaged fileprivate(set) var entries: Set<Entry>
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    var icon: ThoughtIcon {
        get {
            return ThoughtIcon(rawIcon)
        }
        set {
            self.rawIcon = newValue.icon
        }
    }
    
    //MARK: find wether first or last is most recent
    var lastEdited: Date {
        guard let recentEntry: Entry = entries.first else { return date}
        return recentEntry.date
    }
    
    var allEntries: [Entry] {
        get {
            var enwEnt = [Entry]()
            for ent in entries {
                enwEnt.append(ent)
            }
            return enwEnt
        }
    }
    
    var entryCount: EntryCount {
        get {
            let texts: Int = entries.filter( {$0.type == EntryType.text}).count
            let images: Int = entries.filter( {$0.type == EntryType.image}).count
            let recordings: Int = entries.filter( {$0.type == EntryType.recording}).count
            let links: Int = entries.filter( {$0.type == EntryType.link}).count
            return EntryCount(text: texts, images: images, recordings: recordings, links: links)
        }
    }
    
    convenience init(moc: NSManagedObjectContext) {
        self.init(context: moc)
        self.date = Date()
    }
    
    func createThought(title: String, icon: ThoughtIcon) {
        let defaults = UserDefaults.standard
        let num = defaults.integer(forKey: UserDefaults.Keys.thoughtID)
        
        self.date = Date()
        self.icon = icon
        self.title = title
        self.id = "T\(num)"
        
        defaults.set(num + 1, forKey: UserDefaults.Keys.thoughtID)
    }
}
extension Thought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
