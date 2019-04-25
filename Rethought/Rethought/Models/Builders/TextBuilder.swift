
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct TextBuilder: EntryBuilder {
    var type: EntryType = .text
    
    var detail: String
    var title: String
    var entry: Entry
    
    init(detail: String, title: String, forEntry entry: Entry) {
        self.detail = detail
        self.title = title
        self.entry = entry
    }
    
}
