
import Foundation
import UIKit

class ThoughtDetailTableHead: UITableViewCell, Animatable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
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
    public let deleteLabel = AnimatableLabel()
    
    var preview: ThoughtPreview?
    
    let animator = ViewAnimator()
    /*
     animation sizing:
     all animations for views to feel like they arent panning with
     table view need height delta == 100 (superView animation scroll length)
    */
    var titleStartPoint = CGPoint(x: 15, y: 10)
    let endTitlePoint = CGPoint(x: 15, y: 175)
    var titleSize = CGSize.zero
    
    var locationSize = CGSize.zero
    let locationStartPoint = CGPoint(x: 15, y: 185)
    let locationEndPoint = CGPoint(x: -200, y: 250)
    
    let dateSize = CGSize(width: 75, height: 21)
    let dateStartPoint = CGPoint(x: Device.size.width - 90, y: 185)
    let dateEndPoint = CGPoint(x: Device.size.width + 75.0, y: 250)
    
    let deleteStartPoint = CGPoint(x: 15, y: 145)
    let deleteEndPoint = CGPoint(x: -100, y: 215)
    
    let detailPoint = CGPoint(x: 0, y: 220)
    
    func styleView() {
        titleLabel.font = Device.font.title(ofSize: .xXXLarge)
        titleLabel.numberOfLines = 0
        
        locationLabel.text = "Seattle, Washington"
        locationLabel.font = Device.font.mediumTitle(ofSize: .xLarge)
        dateLabel.font = Device.font.body(ofSize: .xLarge)
        
        deleteLabel.text = "Delete"
        deleteLabel.textColor = Device.colors.red
        deleteLabel.font = Device.font.mediumTitle()
        deleteLabel.layer.cornerRadius = 10
        deleteLabel.layer.borderColor = Device.colors.red.cgColor
        deleteLabel.layer.borderWidth = 0.5
        deleteLabel.textAlignment = .center
    }
    
    func setView() {
        //get size from string
        let titleLabelSize = titleLabel.text!.sizeFor(font: Device.font.title(ofSize: .xXXLarge), width: Device.size.width - 100)
        let locationLabelSize = locationLabel.text!.sizeFor(font: Device.font.mediumTitle(ofSize: .xLarge), width: Device.size.width - 50)
        
        // set sizes
        locationSize = locationLabelSize
        titleSize = titleLabelSize
        
        // set frames
        titleLabel.frame = CGRect(origin: titleStartPoint, size: titleLabelSize)
        locationLabel.frame = CGRect(origin: locationStartPoint, size: locationLabelSize)
        dateLabel.frame = CGRect(origin: dateStartPoint, size: dateSize)
        deleteLabel.frame = CGRect(origin: deleteStartPoint, size: CGSize(width: 45, height: 25))
        
        // set frames for animation
        titleLabel.endFrame = CGRect(origin: endTitlePoint, size: titleSize)
        titleLabel.startFrame = CGRect(origin: titleStartPoint, size: titleSize)
        
        locationLabel.startFrame = CGRect(origin: locationStartPoint, size: locationLabelSize)
        locationLabel.endFrame = CGRect(origin: locationEndPoint, size: locationLabelSize)
        
        dateLabel.startFrame = CGRect(origin: dateStartPoint, size: dateSize)
        dateLabel.endFrame = CGRect(origin: dateEndPoint, size: dateSize)
        
        deleteLabel.startFrame = CGRect(origin: deleteStartPoint, size: CGSize(width: 100, height: 25))
        deleteLabel.endFrame = CGRect(origin: deleteEndPoint, size: CGSize(width: 100, height: 25))
        
        // info bar
        detailView = ThoughtDetailInfoBar(point: detailPoint, count: preview?.entryCount ?? EntryCount.zero, icon: preview?.icon ?? "🚦")
        
        // add views to animator
        animator.register(animatableView: titleLabel)
        animator.register(animatableView: deleteLabel)
        animator.register(animatableView: locationLabel)
        animator.register(animatableView: dateLabel)
        animator.register(animatableView: detailView)
        
        // add subviews
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
        addSubview(detailView)
        addSubview(deleteLabel)
    }
    
    public func set(withPreview preview: ThoughtPreview) {
        self.preview = preview
        titleLabel.text = preview.title
        dateLabel.getStringFromDate(date: preview.date, withStyle: .short)
        setView()
    }
    
    func update(toAnimationProgress progress: CGFloat) {
        animator.updateAnimation(toProgress: progress)
        updateConstraints()
    }
}
