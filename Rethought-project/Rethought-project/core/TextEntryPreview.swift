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
        lbl.text = detail
        return lbl.intrinsicContentSize.height
    }
    
    init(_ entry: TextEntry) {
        title = entry.title
        date = entry.date
        location = entry.location
        thoughtIcon = entry.thought.icon
        detail = entry.detail
        id = entry.id
        type = .text
        
        print("text entry preview initiated with height: \(height)")
        print(detail.count)
    }
}

struct EntryPreviews<T> {
    var entries: [T]
    
    init(entries: [T]) {
        self.entries = entries
        
    }
//
//    private func findEntryType() {
//        print(T)
//    }
}
