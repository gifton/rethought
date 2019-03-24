import Foundation
import UIKit
import CoreLocation

struct ThoughtPreview {
    var title:       String
    var date:        Date
    var location:    CLLocation?
    var icon:        String
    var entryCount:  EntryCount
    var recentImage: UIImage?
    
    init(thought: Thought) {
        title = thought.title
        date = thought.date
        icon = thought.icon
        location = thought.location
        entryCount = thought.entryCount
        recentImage = thought.recentImage
    }
    
    init() {
        title = "Do all gang members gatta bang?"
        date = Date()
        location = CLLocation()
        icon = "🔫"
        entryCount = EntryCount(text: 10, images: 12, recordings: 4, links: 25)
    }
}
