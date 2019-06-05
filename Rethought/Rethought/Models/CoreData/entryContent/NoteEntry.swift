
import Foundation
import CoreData
import UIKit

@objc(NoteEntry)
public class NoteEntry: NSManagedObject {
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntry> {
        return NSFetchRequest<NoteEntry>(entityName: "NoteEntry")
    }
    
    // MARK: Objects
    @NSManaged public var title: String?
    @NSManaged public var detail: String
    
    // MARK: Relationship
    @NSManaged public var entry: Entry
    
    // MARK: computed property
    // get minimum height of string labels
    public func minimumHeightForContent(width: CGFloat) -> CGFloat {
        var height: CGFloat = 0.0
        if let title = title {
            height += title.sizeFor(font: Device.font.mediumTitle(ofSize: .xXLarge), width: width).height
        }
        height += detail.sizeFor(font: Device.font.formalBodyText(ofSize: .small), width: width).height
        height += 30
        
        return height
    }

    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: NoteBuilder) -> NoteEntry {
        // set variables from builder
        let note: NoteEntry = context.insertObject()
        note.detail = builder.detail
        note.title = builder.title
        
        guard let entry = builder.entry else {
            print("there was a problem verifying the entry identity")
            return note
        }
        entry.type = EntryType.note.rawValue
        note.entry = entry
        
        return note
    }
}

extension NoteEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
