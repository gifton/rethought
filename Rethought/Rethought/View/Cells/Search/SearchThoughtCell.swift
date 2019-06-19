
import Foundation
import UIKit


class SearchThoughtCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        layoutIfNeeded()
        layer.backgroundColor = UIColor.clear.cgColor
        
        setViews(); styleViews()
    }
    // MARK: Private objects
    let titleLabel = UILabel()
    let thoughtIcon = UILabel()
    let dateLabel = UILabel()
    let locationLabel = UILabel()
    let cell = UIView()
    
    
    private func setViews() {
        
        // super cell
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        cell.layer.cornerRadius = 15
        cell.frame = CGRect(x: 25, y: 5, width: frame.width - 50, height: 90)
        addSubview(cell)
        
        //add views
        cell.addSubview(titleLabel)
        cell.addSubview(thoughtIcon)
        cell.addSubview(dateLabel)
        cell.addSubview(locationLabel)
        
        // place views
        thoughtIcon.frame = CGRect(x: 20, y: 15, width: 35, height: 46)
        titleLabel.frame.origin = CGPoint(x: 55, y: 15)
        titleLabel.frame.size = CGSize(width: cell.frame.width - 90, height: 50)

        dateLabel.frame = CGRect(x: cell.frame.width - 105, y: titleLabel.bottom, width: 100, height: 15)
        locationLabel.frame = CGRect(x: 20, y: titleLabel.bottom, width: 150, height: 15)
    }
    private func styleViews() {
        titleLabel.text = "welcome to rethought! A safe place for you, and your thoughts"
        titleLabel.numberOfLines = 2
        titleLabel.font = Device.font.title(ofSize: .medium)
        titleLabel.textColor = Device.colors.darkGray
        titleLabel.sizeToFit()
        
        thoughtIcon.text = "🚦"
        thoughtIcon.font = Device.font.title(ofSize: .emojiSM)
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .medium)
        dateLabel.font = Device.font.body(ofSize: .small)
        dateLabel.textColor = Device.colors.lightGray
        
        locationLabel.font = Device.font.mediumTitle(ofSize: .small)
        locationLabel.text = "Seattle, Washington"
        locationLabel.textColor = Device.colors.lightGray

    }
    
    public func addContext(_ preview: ThoughtPreview) {
        titleLabel.text = preview.title
        thoughtIcon.text = preview.icon
        dateLabel.getStringFromDate(date: preview.date, withStyle: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
