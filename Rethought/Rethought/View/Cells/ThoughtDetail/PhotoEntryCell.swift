
import Foundation
import UIKit


class PhotoEntryCell: UITableViewCell {
    // MARK: private vars
    var preview: PhotoBuilder?
    var photo: UIImage? {
        guard let preview = preview else { return nil }
        return preview.photo
    }
    // MARK: private objects
    let photoView = UIImageView()
    let detailLabel = UILabel()
    let dateLabel = UILabel()
    let locationLabel = UILabel()
    
    public func add(context payload: PhotoBuilder) {
        preview = payload
    }
    
    private func setViews() {
        
    }
    
    private func styleViews() {
        
    }
    
    private func addContext() {
        
    }
}
