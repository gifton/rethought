
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
    var userDetail: String
    var title: String
    var websiteDescription: String
    static var zero: EntryBuilder {
        return LinkBuilder(link: "", rawIconUrl: "", userDetail: "", title: "", forEntry: nil, websiteDescription: "")
    }
    // MARK: optional values
    var entry: Entry?
    var rawIconUrl: String?
    var thoughtIcon: ThoughtIcon = ThoughtIcon("💭")
    
    init(link: String, rawIconUrl: String?, userDetail: String, title: String, forEntry entry: Entry?, websiteDescription: String) {
        self.link = link
        self.rawIconUrl = rawIconUrl
        self.userDetail = userDetail
        self.title = title
        self.entry = entry
        self.websiteDescription = websiteDescription
    }
    
    init(withEntry link: LinkEntry) {
        self.link = link.url
        rawIconUrl = link.rawIcon
        userDetail = link.detail
        title = link.title
        entry = link.entry
        websiteDescription = link.description
        self.thoughtIcon = ThoughtIcon(link.entry.thought.icon)
    }
}
