
import Foundation
import UIKit

class ThoughtDetailTableHead: UITableViewCell, Animatable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView(); setView()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private objects
    var titleLabel = AnimatableLabel()
    var detailView: ThoughtDetailInfoBar!
    let thoughtContent = UIView()
    let locationLabel = AnimatableLabel()
    let dateLabel = AnimatableLabel()
    
    var preview: ThoughtPreview?
    // sizes for animation
    /*
     all animations for views to feel like they arent panning with
     table view need height delta == 100 (superView animation scroll length)
    */
    var titleStartPoint = CGPoint(x: 15, y: 10)
    let endTitlePoint = CGPoint(x: 15, y: 175)
    var titleSize = CGSize.zero
    
    var locationSize = CGSize.zero
    let locationStartPoint = CGPoint(x: 15, y: 150)
    let locationEndPoint = CGPoint(x: -200, y: 250)
    
    let dateSize = CGSize(width: 75, height: 21)
    let dateStartPoint = CGPoint(x: Device.size.width - 100, y: 150)
    let dateEndPoint = CGPoint(x: Device.size.width + 75.0, y: 250)
    
    let detailPoint = CGPoint(x: 0, y: 220)
    
    func styleView() {
        titleLabel.text = "Whats the square root of 69? 8 something?"
        titleLabel.font = Device.font.mediumTitle(ofSize: .xXXLarge)
        titleLabel.numberOfLines = 0
        
        locationLabel.text = "Seattle, Washington"
        locationLabel.font = Device.font.mediumTitle(ofSize: .xLarge)
        
        dateLabel.text = "3-24-95"
        dateLabel.font = Device.font.body(ofSize: .xLarge)
    }
    
    func setView() {
        //get size from string
        let titleLabelSize = titleLabel.text!.sizeFor(font: Device.font.mediumTitle(ofSize: .xXXLarge), width: Device.size.width - 50)
        let locationLabelSize = locationLabel.text!.sizeFor(font: Device.font.mediumTitle(ofSize: .xLarge), width: Device.size.width - 50)
        
        // set sizes
        locationSize = locationLabelSize
        titleSize = titleLabelSize
        
        // set frames
        titleLabel.frame = CGRect(origin: titleStartPoint, size: titleLabelSize)
        locationLabel.frame = CGRect(origin: locationStartPoint, size: locationLabelSize)
        dateLabel.frame = CGRect(origin: dateStartPoint, size: dateSize)
        
        // set frames for animation
        titleLabel.endFrame = CGRect(origin: endTitlePoint, size: titleSize)
        titleLabel.startFrame = CGRect(origin: titleStartPoint, size: titleSize)
        
        locationLabel.startFrame = CGRect(origin: locationStartPoint, size: locationLabelSize)
        locationLabel.endFrame = CGRect(origin: locationEndPoint, size: locationLabelSize)
        
        dateLabel.startFrame = CGRect(origin: dateStartPoint, size: dateSize)
        dateLabel.endFrame = CGRect(origin: dateEndPoint, size: dateSize)
        
        // info bar
        detailView = ThoughtDetailInfoBar(point: detailPoint, count: preview?.entryCount ?? EntryCount.zero, icon: preview?.icon ?? "🚦")
        
        // add subviews
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(detailView)
    }
    
    public func set(withPreview preview: ThoughtPreview) {
        self.preview = preview
    }
    
    func update(toAnimationProgress progress: CGFloat) {
        titleLabel.update(toAnimationProgress: progress)
        locationLabel.update(toAnimationProgress: progress)
        dateLabel.update(toAnimationProgress: progress)
        detailView.update(toAnimationProgress: progress * 2.5)
        updateConstraints()
    }
}
