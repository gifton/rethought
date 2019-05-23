
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
        
        let img: PhotoEntry = context.insertObject()
        img.detail = builder.userDetail
        img.rawPhoto = builder.photo.pngData()!
        
        guard let entry = builder.entry else {
            print("there was a problem verifying the entry identity")
            return img
        }
        img.entry = entry
        
        return img
    }
}

extension PhotoEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
