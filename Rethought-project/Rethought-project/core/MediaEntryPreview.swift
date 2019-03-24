
import Foundation
import UIKit
import CoreLocation

struct MediaEntryPreview: Entry {
    
    var type:        EntryType
    var id:          String
    var image:       UIImage
    var detail:      String
    var date:        Date
    var location:    CLLocation?
    var thoughtIcon: String
    var height: CGFloat {
        return image.size.height
    }
    
    init(_ entry: MediaEntry) {
        detail = entry.detail
        date = entry.date
        location = entry.location
        thoughtIcon = entry.thought.icon
        image = entry.media
        id = entry.id
        type = .media
    }
}
