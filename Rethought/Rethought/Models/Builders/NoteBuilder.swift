
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct NoteBuilder: EntryBuilder {
    // MARK: required values
    var type: EntryType = .note
    var detail: String
    var title: String
    static var zero: EntryBuilder {
        return NoteBuilder(detail: "", title: "", forEntry: nil)
    }
    // MARK: required values
    var entry: Entry?
    var thoughtIcon: ThoughtIcon = ThoughtIcon("💭")
    
    init(detail: String, title: String, forEntry entry: Entry?) {
        self.detail = detail
        self.title = title
        self.entry = entry
    }
    
    init(withNote note: NoteEntry) {
        self.detail = note.detail
        self.title = note.title ?? "No title available"
        self.entry = note.entry
        self.thoughtIcon = ThoughtIcon(note.entry.thought.icon)
    }
    
}
