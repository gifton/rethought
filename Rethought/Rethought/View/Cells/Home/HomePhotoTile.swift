
import Foundation
import UIKit

class HomePhotoTile: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        backgroundColor = .green
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    public func addContext(context: PhotoBuilder) {
        print(context)
        photo.image = context.photo
        dateLabel.getStringFromDate(date: context.entry?.date ?? Date(), withStyle: .short)
        thoughtIcon.text = context.thoughtIcon.icon
        
        addContext()
    }
    
    private var photo = UIImageView()
    private var dateLabel = UILabel()
    private var thoughtIcon = UILabel()
    private var iconFrame = UIView()
    
    private func addContext() {
        photo.contentMode = .scaleToFill
        photo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photo)
        
        photo.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        print("added photo to cell")
    }
}

