
import Foundation
import UIKit

/// when saving a new link, initiate LinkBuilder
/// after building new entry to attach too
/// to capture link content to be attached to an entry
struct PhotoBuilder: EntryBuilder {
    
    // MARK: required values
    var type: EntryType = .photo
    var photo: UIImage
    var userDetail: String
    var photoHeight: CGFloat = 0
    var date: Date = Date()
    static var zero: EntryBuilder {
        return PhotoBuilder(photo: UIImage(), userDetail: "", forEntry: nil)
    }
    // MARK: optional values
    var entry: Entry?
    var thoughtIcon: ThoughtIcon = ThoughtIcon("💭")
    
    init(photo: UIImage, userDetail: String, forEntry entry: Entry?) {
        self.photo = photo
        self.userDetail = userDetail
        self.entry = entry
        date = entry?.date ?? Date()
    }
    
    init(withEntry entry: PhotoEntry) {
        photo = UIImage(data: entry.rawPhoto) ?? #imageLiteral(resourceName: "camera_light")
        userDetail = entry.detail ?? ""
        self.entry = entry.entry
        date = entry.entry.date
    }
    
    init(withEntry entry: PhotoEntry, forWidth width: CGFloat) {
        photo = UIImage(data: entry.rawPhoto) ?? #imageLiteral(resourceName: "camera_light")
        userDetail = entry.detail ?? ""
        self.entry = entry.entry
        photoHeight = entry.photoHeight(forWidth: width)
        thoughtIcon = ThoughtIcon(entry.entry.thought.icon)
        date = entry.entry.date
    }
    
    public mutating func setHeight(forPhotoWidth width: CGFloat) {
        guard let scaledPhoto = photo.scaled(toWidth: width) else {
            print("unable to scale photo in PhotoBuilder setHeight(forPhotoWidth:) func")
            return
        }
        photoHeight = scaledPhoto.size.height
    }

}
