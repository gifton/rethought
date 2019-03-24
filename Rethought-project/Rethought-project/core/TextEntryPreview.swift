import Foundation
import CoreLocation
import UIKit

struct TextEntryPreview: Entry {
    
    var title:       String
    var detail:      String
    var date:        Date
    var location:    CLLocation?
    var thoughtIcon: String
    var id:          String
    var type:        EntryType
    var height: CGFloat {
        let lbl = UILabel()
        lbl.text = title
        return lbl.requiredHeight
    }
    
    init(_ entry: TextEntry) {
        title = entry.title
        date = entry.date
        location = entry.location
        thoughtIcon = entry.thought.icon
        detail = entry.detail
        id = entry.id
        type = .text
    }
}
