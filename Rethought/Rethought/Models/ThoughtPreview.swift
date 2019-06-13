
import UIKit
import CoreLocation

// displaying thoughts in scroll views doenst require all thought data,
// this object makes passing data more concise
struct ThoughtPreview {
    var title:       String
    var date:        Date = Date()
    var location:    CLLocation?
    var icon:        String
    var entryCount:  EntryCount
    var recentPhoto: UIImage?
    
    init(thought: Thought) {
        title = thought.title
        date = thought.date
        icon = thought.icon
        location = thought.location
        entryCount = thought.entryCount
        recentPhoto = thought.recentPhoto
    }
    
    init(title: String, icon: String, location: CLLocation?) {
        self.title = title
        self.location = location
        self.icon = icon
        date = Date()
        entryCount = EntryCount(notes: 0, photos: 0, recordings: 0, links: 0)
    }
    
    static var zero: ThoughtPreview {
        return ThoughtPreview(title: "Awesome Photos on wesat", icon: "🔫", location: CLLocation())
    }
}
