
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
/// all links stored as Strings, must be unwrapped
struct LinkBuilder: EntryBuilder {
    
    // MARK: required values
    var type: EntryType = .link
    var link: String
    var detail: String
    var title: String
    static var zero: EntryBuilder {
        return LinkBuilder(link: "", rawIconUrl: "", detail: "", title: "", forEntry: nil)
    }
    // MARK: optional values
    var entry: Entry?
    var rawIconUrl: String?
    var thoughtIcon: ThoughtIcon = ThoughtIcon("💭")
    
    init(link: String, rawIconUrl: String?, detail: String, title: String, forEntry entry: Entry?) {
        self.link = link
        self.rawIconUrl = rawIconUrl
        self.detail = detail
        self.title = title
        self.entry = entry
    }
    
    init(withEntry link: LinkEntry) {
        self.link = link.url
        rawIconUrl = link.rawIcon
        detail = link.detail
        title = link.title
        entry = link.entry
        self.thoughtIcon = ThoughtIcon(link.entry.thought.icon)
    }
}
