
import Foundation
import CoreData

@objc(LinkEntry)
public class LinkEntry: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LinkEntry> {
        return NSFetchRequest<LinkEntry>(entityName: "LinkEntry")
    }
    
    // MARK: Objects
    @NSManaged public var title: String
    @NSManaged public var url: String
    @NSManaged public var rawIcon: String
    @NSManaged public var detail: String
    
    // MARK: Relationship
    @NSManaged public var entry: Entry

    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: LinkBuilder) -> LinkEntry {
        
        // set variables from builder
        let link: LinkEntry = context.insertObject()
        link.detail = builder.userDetail
        link.entry = builder.entry
        link.rawIcon = builder.rawIconUrl
        
        return link
    }
}


extension LinkEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(title), ascending: false)]
    }
}
