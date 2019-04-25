
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct LinkBuilder: EntryBuilder {
    var type: EntryType = .link
    
    var link: String
    var rawIconUrl: String
    var userDetail: String
    var title: String
    var entry: Entry
    
    init(link: String, rawIconUrl: URL, userDetail: String, title: String, forEntry entry: Entry) {
        self.link = link
        self.rawIconUrl = String(describing: rawIconUrl)
        self.userDetail = userDetail
        self.title = title
        self.entry = entry
    }
    
}
