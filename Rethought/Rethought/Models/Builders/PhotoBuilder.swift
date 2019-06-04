
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct PhotoBuilder: EntryBuilder {
    var type: EntryType = .photo
    
    var photo: UIImage
    var userDetail: String
    var entry: Entry?
    
    init(photo: UIImage, userDetail: String, forEntry entry: Entry?) {
        self.photo = photo
        self.userDetail = userDetail
        self.entry = entry
    }
    
    init(withEntry entry: PhotoEntry) {
        photo = UIImage(data: entry.rawPhoto) ?? #imageLiteral(resourceName: "camera_light")
        userDetail = entry.detail ?? ""
        self.entry = entry.entry
    }
}
