
import Foundation
import CoreData
import CoreLocation

class ThoughtBuilderViewModel: NSObject {
    init(withContext context: NSManagedObjectContext) {
        self.moc = context
    }
    
    private var moc: NSManagedObjectContext
    private var currentThoughtPreview = ThoughtPreview()
    private var currentThought: Thought?
}


extension ThoughtBuilderViewModel: ThoughtBuilderViewModelDelegate {
    
    func saveThought() -> Bool {
        do {
            try moc.save()
            return true
        } catch let err {
            print(err)
            return false
        }
    }
    
    func buildThought(withTitle title: String, withLocation location: CLLocation?, withIcon icon: ThoughtIcon) {
        currentThoughtPreview.title = title
        currentThoughtPreview.location = location
        currentThoughtPreview.icon = icon.icon
    }
    
    func buildEntry<T>(payload: T, withLocation location: CLLocation?) where T : EntryBuilder {
        let entry = Entry.insertEntry(into: moc, location: location, payload: payload)
        entry.willSave()
    }
    
    func saveEntries() -> Bool {
        do {
            try moc.save()
            return true
        } catch let err {
            print(err)
            return false
        }
    }
    
    func updateThoughtIcon(toIcon icon: ThoughtIcon) {
        guard let currentThought = currentThought else { return }
        
        currentThought.icon = icon.icon
        _ = saveThought()
    }
    
    
}
