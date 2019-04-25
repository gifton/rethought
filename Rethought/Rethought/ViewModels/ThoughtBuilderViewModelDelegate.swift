
import Foundation
import CoreLocation

protocol ThoughtBuilderViewModelDelegate {
    func saveThought() -> Bool
    func buildThought(withTitle title: String, withLocation location: CLLocation?, withIcon icon: ThoughtIcon)
    
    func buildEntry<T: EntryBuilder>(payload: T, withLocation location: CLLocation?)
    func saveEntries() -> Bool
    
    func updateThoughtIcon(toIcon icon: ThoughtIcon)
}
