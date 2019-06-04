
import Foundation
import CoreData
import UIKit

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
    
    // MARK: computed property
    public func minimumHeightForContent(width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        
        // get photo height
        height += photoHeight(forWidth: width)
        
        // confirm text
        guard let detail = detail else {
            return height
        }
        
        // add detail height for content
        height += detail.sizeFor(font: Device.font.mediumTitle(ofSize: .xXLarge), width: width).height
        height += 150
        print("photoEntryHeight: \(height)")
        return height
    }
    
    // calculate height of photo after resize
    public func photoHeight(forWidth width: CGFloat) -> CGFloat {
        guard let photo = UIImage(data: rawPhoto),
            let scaledPhoto = photo.scaled(toWidth: width) else {
                return 0
        }
        return scaledPhoto.size.height
    }
    
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
