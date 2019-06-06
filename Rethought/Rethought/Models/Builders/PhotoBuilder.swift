
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct PhotoBuilder: EntryBuilder {
    var thoughtIcon: ThoughtIcon = ThoughtIcon("💭")
    var type: EntryType = .photo
    var photo: UIImage
    var userDetail: String
    var entry: Entry?
    var photoHeight: CGFloat = 0
    
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
    
    init(withEntry entry: PhotoEntry, forWidth width: CGFloat) {
        photo = UIImage(data: entry.rawPhoto) ?? #imageLiteral(resourceName: "camera_light")
        userDetail = entry.detail ?? ""
        self.entry = entry.entry
        photoHeight = entry.photoHeight(forWidth: width)
        self.thoughtIcon = ThoughtIcon(photo.entry.thought.icon)
    }
    
    public func setHeight(forPhotoWidth width: CGFloat) {
        guard let scaledPhoto = photo.scaled(toWidth: width) else {
            return 0
        }
        photoHeight = photo.
    }

}
