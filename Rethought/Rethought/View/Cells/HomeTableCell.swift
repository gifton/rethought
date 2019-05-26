
import Foundation
import UIKit

class HomeTableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Device.colors.offWhite
        setCell()
    }
    
    let cell = UIView()
    let moreBtn = UIButton()
    var entry: Entry?
    let typeImage = UIImageView()
    let dateLabel = UILabel()
    let titleLabel = UILabel()
    
    func setCell() {
        addSubview(cell)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .white
        cell.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingBottom: 5, paddingTrailing: 10)
        setViews()
    }
    
    public func insert(payload entry: Entry) {
        self.entry = entry
        dateLabel.getStringFromDate(date: entry.date, withStyle: .medium)
        switch entry.type {
        case EntryType.link.rawValue:
            typeImage.image = #imageLiteral(resourceName: "compass_gradient")
            titleLabel.text = entry.link?.title
        case EntryType.note.rawValue:
            typeImage.image = #imageLiteral(resourceName: "note_gradient")
            titleLabel.text = entry.note?.title
        case EntryType.photo.rawValue:
            typeImage.image = #imageLiteral(resourceName: "Image_gradient")
            titleLabel.text = entry.photo?.detail
        case EntryType.recording.rawValue:
            typeImage.image = #imageLiteral(resourceName: "microphone_gradient")
            titleLabel.text = entry.recording?.detail
        default:
            print("cell image set to: nil")
            return
        }
        
        cell.addSubview(typeImage)
        cell.addSubview(titleLabel)
        cell.addSubview(dateLabel)
        
        typeImage.translatesAutoresizingMaskIntoConstraints = false
        typeImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        typeImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 25).isActive = true
        
        titleLabel.setAnchor(top: cell.topAnchor, leading: typeImage.trailingAnchor, bottom: nil, trailing: moreBtn.leadingAnchor, paddingTop: 25, paddingLeading: 10, paddingBottom: 0, paddingTrailing: 25)
        
        dateLabel.setAnchor(top: titleLabel.bottomAnchor, leading: typeImage.trailingAnchor, bottom: bottomAnchor, trailing: moreBtn.leadingAnchor, paddingTop: -10, paddingLeading: 10, paddingBottom: 20, paddingTrailing: 25)
        
        titleLabel.font = Device.font.body(ofSize: .large)
        titleLabel.textColor = Device.colors.darkGray
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        dateLabel.font = Device.font.title(ofSize: .large)
        dateLabel.textColor = Device.colors.darkGray
        
        typeImage.setHeightWidth(width: 30, height: 30)
        typeImage.contentMode = .scaleAspectFit
        
        
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    public func setButtonTargets(_ action: @escaping (_ entry: Entry) -> Void) {
        moreBtn.addTapGestureRecognizer {
            action(self.entry!)
            self.moreBtn.imageView?.layer.add(self.bounceAnimation, forKey: nil)
        }
        moreBtn.doesEnable()
    }
    
    private func setViews() {
        cell.addSubview(moreBtn)
        
        moreBtn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        moreBtn.frame = CGRect(x: frame.width + 25, y: 30, width: 10, height: 30)
    }
    
    static var identifier: String {
        return "HomeTableCellV1"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isTapped() {
        
    }
}
