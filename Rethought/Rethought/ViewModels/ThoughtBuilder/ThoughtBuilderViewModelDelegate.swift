
import Foundation
import CoreLocation

protocol ThoughtBuilderViewModelDelegate {
    func save()
    func buildThought(withTitle title: String, withLocation location: CLLocation?, withIcon icon: ThoughtIcon) -> ThoughtPreview
    func buildEntry<T: EntryBuilder>(payload: T, withLocation location: CLLocation?)
    func updateThoughtIcon(toIcon icon: ThoughtIcon)
}
