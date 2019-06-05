

import Foundation
import CoreData
import UIKit


class EntryDetailViewModel: EntryDetailViewModelDelegate {
    required init(withEntry entry: Entry, _ moc: NSManagedObjectContext) {
        self.entry = entry
    }
    
    
    var entry: Entry
    var entryType: EntryType {
        get {
            return entry.computedEntryType
        }
    }
    var heightForContent: CGFloat {
        get {
            return entry.heightForContent(width: Device.size.width - 60)
        }
    }
    
    
}


extension EntryDetailViewModel {
    func deleteEntry() { }
    
    func save() { }
}
