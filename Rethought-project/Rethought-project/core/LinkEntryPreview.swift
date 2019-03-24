import Foundation
import UIKit

struct LinkEntryPreview: Entry {
    
    var id:               String
    var type:             EntryType
    var thoughtID:        String
    var date:             Date
    var image:            UIImage?
    var title:            String
    var thoughtIcon:      String
    var linkDescription:  String?
    var link:             String?
    var linkTitle:        String?
    
    init(_ entry: LinkEntry) {
        id = entry.id
        thoughtID = entry.thought.id
        date = entry.date
        image = entry.linkIcon
        title = entry.linkTitle
        thoughtIcon = entry.thought.icon
        linkDescription = entry.linkDescription
        link = entry.link
        linkTitle = entry.linkTitle
        type = .link
    }
}
