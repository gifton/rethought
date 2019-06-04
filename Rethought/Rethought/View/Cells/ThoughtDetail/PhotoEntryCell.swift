
import Foundation
import UIKit


class PhotoEntryCell: UITableViewCell {
    // MARK: private vars
    
    private let detailFont = Device.font.formalBodyText(ofSize: .small)
    private let auxilaryFont = Device.font.mediumTitle(ofSize: .medium)
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
        addContext()
        styleViews()
        setViews()
    }
    
    private func setViews() {
        guard let preview = preview else { return }
        let detailHeight = preview.userDetail.sizeFor(font: detailFont, width: frame.width - 20).height
        print("height from cell:", preview.photoHeight)
        print(frame)
        photoView.frame = CGRect(x: 10, y: 20, width: frame.width - 20, height: preview.photoHeight)
        locationLabel.frame = CGRect(x: 10, y: frame.height - 35, width: frame.width / 3, height: 15)
        dateLabel.frame = CGRect(x: frame.width - 75, y: frame.height - 35, width: 100, height: 15)
        detailLabel.frame = CGRect(x: 10, y: preview.photoHeight + 30, width: frame.width - 20, height: detailHeight)
        
        addSubview(photoView)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(detailLabel)
    }
    
    private func styleViews() {
        //detail
        detailLabel.font = detailFont
        // location
        locationLabel.font = auxilaryFont
        locationLabel.textColor = .black
        // date
        dateLabel.font = auxilaryFont
        dateLabel.textColor = .black
        // photo
        photoView.contentMode = .scaleAspectFit
        
    }
    
    private func addContext() {
        photoView.image = photo
        detailLabel.text = preview?.userDetail
        dateLabel.getStringFromDate(date: Date(), withStyle: .short)
        locationLabel.text = "Seattle, Washington"
    }
}
