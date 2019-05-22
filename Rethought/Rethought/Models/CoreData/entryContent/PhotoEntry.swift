
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
        guard let entry = builder.entry else {
            print("there was a problem verifying the entry identity")
            return PhotoEntry(context: context)
        }
        let img: PhotoEntry = context.insertObject()
        img.detail = builder.userDetail
        img.entry = entry
        img.rawPhoto = builder.photo.pngData()!
        entry = img.entry
        
        return img
    }
}

extension PhotoEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
