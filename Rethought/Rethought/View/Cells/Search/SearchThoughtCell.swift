
import Foundation
import UIKit


class SearchThoughtCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        cell.backgroundColor = UIColor(hex: "F2F4F6")
        cell.layer.cornerRadius = 15
        cell.frame = CGRect(x: 25, y: 5, width: frame.width - 50, height: 90)
        addSubview(cell)
        //add views
        cell.addSubview(titleLabel)
        cell.addSubview(thoughtIcon)
        cell.addSubview(dateLabel)
        cell.addSubview(locationLabel)
        
        // place views
        thoughtIcon.frame = CGRect(x: 10, y: 15, width: 35, height: 46)
        titleLabel.frame.origin = CGPoint(x: 10, y: 65)
        titleLabel.frame.size.width = frame.width - 80
        dateLabel.frame = CGRect(x: 130, y: frame.height - 30, width: 150, height: 15)
        locationLabel.frame = CGRect(x: 25, y: frame.height - 30, width: 105, height: 15)
    }
    private func styleViews() {
        titleLabel.text = "welcome to rethought! A safe place for you, and your thoughts"
        titleLabel.numberOfLines = 2
        titleLabel.font = Device.font.mediumTitle()
        titleLabel.textColor = Device.colors.darkGray
        titleLabel.sizeToFit()
        
        thoughtIcon.text = "🚦"
        thoughtIcon.font = Device.font.title(ofSize: .emojiSM)
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .medium)
        dateLabel.font = Device.font.body(ofSize: .small)
        
        locationLabel.font = Device.font.mediumTitle(ofSize: .small)
        locationLabel.text = "Seattle, Washington"

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
