

import Foundation
import CoreData
import UIKit


class EntryDetailViewModel: EntryDetailViewModelDelegate {
    required init(withEntry entry: Entry, _ moc: NSManagedObjectContext) {
        self.entry = entry
    }
    
    // MARK: public objects
    public var entry: Entry
    public var entryType: EntryType { return entry.computedEntryType }
    public var heightForContent: CGFloat { return entry.heightForContent(width: Device.size.width - 60) }
    public var builder: EntryBuilder {
        return entry.associatedBuilder
    }
    
}


extension EntryDetailViewModel {
    func deleteEntry() { }
    
    func save() { }
}
