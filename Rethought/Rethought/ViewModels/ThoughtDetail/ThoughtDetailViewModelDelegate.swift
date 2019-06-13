
import Foundation
import CoreData
import CoreLocation

protocol ThoughtDetailViewModelDelegate {
    init(withThought thought: Thought, _ moc: NSManagedObjectContext)
    func buildEntry<T: EntryBuilder>(payload: T, withLocation location: CLLocation?, completion: () -> ())
    func updateThoughtIcon(toIcon icon: ThoughtIcon)
    func delete(entryAtIndex index: Int, completion: () -> ())
    func deleteThought(completion: () -> ())
    func save()
    func search(_ payload: String, completion: () -> ())
}
