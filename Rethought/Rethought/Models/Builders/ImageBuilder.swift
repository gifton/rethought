
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct ImageBuilder: EntryBuilder {
    var type: EntryType = .image
    
    var image: Data
    var userDetail: String
    var entry: Entry
    
    init(link: String, image: Data, userDetail: String, forEntry entry: Entry) {
        self.image = image
        self.userDetail = userDetail
        self.entry = entry
    }
    
}
