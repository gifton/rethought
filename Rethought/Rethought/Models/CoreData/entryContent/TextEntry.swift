
import Foundation
import CoreData

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

    // conveinance func for builders
    static func insert(into context: NSManagedObjectContext, builder: NoteBuilder) -> NoteEntry {
        guard let entry = builder.entry else {
            print("there was a problem verifying the entry identity")
            return NoteEntry(context: context)
        }
        // set variables from builder
        let note: NoteEntry = context.insertObject()
        note.detail = builder.detail
        note.title = builder.title
        note.entry = entry
        
        return note
    }
}

extension NoteEntry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(detail), ascending: false)]
    }
}
