
import Foundation
import CoreData
import CoreLocation

protocol ThoughtDetailViewModelDelegate {
    init(withThought thought: Thought, _ moc: NSManagedObjectContext)
    func buildEntry<T: EntryBuilder>(payload: T, withLocation location: CLLocation?)
    func updateThoughtIcon(toIcon icon: ThoughtIcon)
    func delete(entryWithID id: String)
    func deleteThought()
    func save()
    func search(_ payload: String)
}
