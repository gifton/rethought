
import Foundation
import UIKit


class ThoughtCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        isOpaque = true
        
        layoutIfNeeded()
        layer.backgroundColor = UIColor.clear.cgColor
        
        setViews(); styleViews()
    }
    // MARK: Private objects
    let titleLabel = UILabel()
    let thoughtIcon = UILabel()
    let dateLabel = UILabel()
    let locationLabel = UILabel()
    var count = EntryCount(notes: 0, photos: 0, recordings: 0, links: 0)
    
    
    private func setViews() {
        //add views
        addSubview(titleLabel)
        addSubview(thoughtIcon)
        addSubview(dateLabel)
        addSubview(locationLabel)
        
        // place views
        thoughtIcon.frame = CGRect(x: 25, y: 20, width: 35, height: 46)
        titleLabel.frame = CGRect(x: 75 , y: 20, width: frame.width - 95, height: 100)
        dateLabel.frame = CGRect(x: 25, y: frame.height - 55, width: 150, height: 15)
        locationLabel.frame = CGRect(x: 25, y: frame.height - 30, width: 150, height: 15)
    }
    private func styleViews() {
        titleLabel.text = "welcome to rethought! A safe place for you, and your thoughts"
        titleLabel.numberOfLines = 0
        titleLabel.font = Device.font.mediumTitle()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = Device.colors.offWhite
        
        thoughtIcon.text = "🚦"
        thoughtIcon.font = Device.font.title(ofSize: .emojiLG)
        
        dateLabel.getStringFromDate(date: Date(), withStyle: .medium)
        dateLabel.font = Device.font.body(ofSize: .small)
        dateLabel.textColor = .white
        
        locationLabel.font = Device.font.mediumTitle(ofSize: .small)
        locationLabel.text = "Seattle, Washington"
        locationLabel.textColor = .white
    }
    
    public func addContext(_ preview: ThoughtPreview) {
        titleLabel.text = preview.title
        thoughtIcon.text = preview.icon
        dateLabel.getStringFromDate(date: preview.date, withStyle: .medium)
        count = preview.entryCount
        
        let nView = EntryCountBlock(withCount: preview.entryCount, frame: CGRect(x: 165, y: 160, width: 120, height: 35))
        addSubview(nView)
    }
    
    // funcs and variables for smooth cornering
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePath()
    }
    
    var radius: CGFloat = 25
    private var path: UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        guard let path = path,
            let context = UIGraphicsGetCurrentContext() else {
                print("returning")
                return
        }
        
        context.clear(rect)
        UIColor.white.withAlphaComponent(0.15).setFill()
        path.fill()
    }
    
    private func updatePath() {
        let path = UIBezierPath.continuousRoundedRect(bounds, cornerRadius: (topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius))
        
        layer.shadowPath = path.cgPath
        
        self.path = path
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
