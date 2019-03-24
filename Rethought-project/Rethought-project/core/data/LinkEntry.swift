
import Foundation
import CoreData
import UIKit
import CoreLocation

@objc(LinkEntry)
public class LinkEntry: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LinkEntry> {
        return NSFetchRequest<LinkEntry>(entityName: "LinkEntry")
    }
    
    @NSManaged public var date: Date
    @NSManaged public var detail: String?
    @NSManaged public var id: String
    @NSManaged public var isFavorite: Bool
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var link: String
    @NSManaged public var linkDescription: String
    @NSManaged public var linkTitle: String
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var rawLinkIcon: Data
    @NSManaged public var thought: Thought
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    var linkIcon: UIImage {
        get {
            guard let image = UIImage(data: rawLinkIcon) else { return #imageLiteral(resourceName: "linkImagePlaceholder") }
            return image
        }
    }
    
    //set new link entry
    static func insert(into context: NSManagedObjectContext,
                       link: String, linkIcon: UIImage, linkDescription: String, linkTitle: String,
                       location: CLLocation?,
                       detail: String?, thought: Thought) -> LinkEntry {
        
        let entry: LinkEntry = context.insertObject()
        
        //get ID number count from defaults, and increment
        let defaults = UserDefaults.standard
        let entryNum: Int = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        //get image png data
        guard let imgData = linkIcon.pngData() else {
            print("unable to decode image data, handing an empty entry")
            defaults.set(entryNum + 1, forKey: UserDefaults.Keys.entryID)
            return entry
        }
        
        //set variables
        entry.id = "rt-pDB-E\(entryNum)"
        entry.date = Date()
        entry.detail = detail
        entry.isFavorite = false
        entry.link = link
        entry.linkDescription = linkDescription
        entry.linkTitle = linkTitle
        entry.rawLinkIcon = imgData
        entry.thought = thought
        
        //save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(entryNum + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
    
    //link preview object
    var preview: LinkEntryPreview {
        get {
            return LinkEntryPreview(self)
        }
    }
    
    func setFavorite(_ input: Bool) {
        self.isFavorite = input
    }
}
extension LinkEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
