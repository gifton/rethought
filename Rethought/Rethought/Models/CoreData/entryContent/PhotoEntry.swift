
import Foundation
import CoreData

@objc(PhotoEntry)
public class PhotoEntry: NSManagedObject {


    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntry> {
        return NSFetchRequest<PhotoEntry>(entityName: "PhotoEntry")
    }
    
    
    // MARK: Objects
    @NSManaged public var rawPhoto: Data
    @NSManaged public var detail: String?
    
    // MARK: Relationship
    @NSManaged public var entry: Entry
    
    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: PhotoBuilder) -> PhotoEntry {
        
        let photo: PhotoEntry = context.insertObject()
        photo.detail = builder.userDetail
        photo.rawPhoto = builder.photo.pngData()!
        
        guard let entry = builder.entry else {
            print("there was a problem verifying the entry identity")
            return photo
        }
        entry.type = EntryType.photo.rawValue
        photo.entry = entry
        
        return photo
    }
}

extension PhotoEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
