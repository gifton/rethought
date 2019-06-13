
import Foundation
import CoreData
import UIKit
import CoreLocation

@objc(Thought)
public class Thought: NSManagedObject {

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
    var allEntries: [Entry] {
        var out = [Entry]()
        guard let entries = entries else { return out }
        for entry in entries {
            guard let computedEntry: Entry = entry as? Entry else {
                print("computed entry is unreachable from thought object")
                return out
            }
            out.append(computedEntry)
        }
        
        out.sort { (ent1, ent2) -> Bool in
            ent1.date > ent2.date
        }
        return out
    }
    var thoughtIcon: ThoughtIcon { return ThoughtIcon(icon) }
    
    var preview: ThoughtPreview? {
        if isDeleted { return nil }
//        date = Date()
        let preview = ThoughtPreview(thought: self)
        return preview        
    }
    
    var entryCount: EntryCount {
        guard let counts = entries else {
            return EntryCount(notes: 0, photos: 0, recordings: 0, links: 0)
        }
        var notes = 0
        var photo = 0
        var link = 0
        var recording = 0
        counts.forEach { (entry) in
            if let ent = entry as? Entry {
                switch ent.type {
                case "LINK": link += 1
                case "NOTE": notes += 1
                case "RECORDING": recording += 1
                case "PHOTO": photo += 1
                default: print("unknown entry type")
                }
            }
        }
        return EntryCount(notes: notes, photos: photo, recordings: recording, links: link)
    }
    
    // search for most recent image entry image, convert to data and return
    public var recentPhoto: UIImage? {
        guard let entries = self.entries else {
            return nil
        }
        
        for ent in entries {
            
            if let entry = ent as? Entry {
                guard let data = entry.rawPhoto else { return nil }
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    // calculate all necessary heights
    public func getHeights(andWidth width: CGFloat) -> [CGFloat] {
        var floats = [CGFloat]()
        for entry in allEntries {
            floats.append(entry.heightForContent(width: width))
        }
        
        return floats
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
    
    //build thought components from thought preview
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
    
    public func deleteEntry(withID id: String) {
        
        let out = allEntries.filter {
            if $0.id == id {
                return true
            }
            return false
        }
        for ent in out {
            managedObjectContext?.delete(ent)
        }
    }
    
    public func removeSelf() {
        managedObjectContext?.delete(self)
    }
    
}

extension Thought: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
