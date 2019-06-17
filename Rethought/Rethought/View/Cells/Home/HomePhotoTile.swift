
import Foundation
import UIKit

class HomePhotoTile: UICollectionViewCell, BuilderContext {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    func addContext(_ builder: EntryBuilder) {
        guard let context: PhotoBuilder = builder as? PhotoBuilder else { return }
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
        //mask translation set to false
        photo.translatesAutoresizingMaskIntoConstraints = false
        iconFrame.translatesAutoresizingMaskIntoConstraints = false
        thoughtIcon.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(photo)
        addSubview(dateLabel)
        addSubview(iconFrame)
        iconFrame.addSubview(thoughtIcon)
        
        photo.contentMode = .scaleToFill
        photo.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        photo.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        iconFrame.backgroundColor = .white
        iconFrame.addShadow(offset: CGSize(width: 4, height: 4))
        iconFrame.setHeightWidth(width: 40, height: 40)
        iconFrame.layer.cornerRadius = 20
        iconFrame.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 8, paddingLeading: 8)
        
        thoughtIcon.font = Device.font.body(ofSize: .large)
        thoughtIcon.textAlignment = .center
        thoughtIcon.setAnchor(top: iconFrame.topAnchor, leading: iconFrame.leadingAnchor, bottom: iconFrame.bottomAnchor, trailing: iconFrame.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        dateLabel.font = Device.font.title(ofSize: .large)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.addShadow(offset: CGSize(width: 2, height: 2))
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}

