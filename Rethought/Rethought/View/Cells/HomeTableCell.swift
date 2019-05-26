
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
    
    func setCell() {
        addSubview(cell)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .white
        cell.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingBottom: 5, paddingTrailing: 10)
        setViews()
    }
    
    public func insert(payload entry: Entry) {
        self.entry = entry
        switch entry.type {
        case EntryType.link.rawValue:
            typeImage.image = #imageLiteral(resourceName: "compass_gradient")
            print("cell image set to: image")
        case EntryType.note.rawValue:
            typeImage.image = #imageLiteral(resourceName: "note_gradient")
            print("cell image set to: note")
        case EntryType.photo.rawValue:
            typeImage.image = #imageLiteral(resourceName: "Image_gradient")
            print("cell image set to: photo")
        case EntryType.recording.rawValue:
            typeImage.image = #imageLiteral(resourceName: "microphone_gradient")
            print("cell image set recording: image")
        default:
            print("cell image set to: nil")
            return
        }
        
        cell.addSubview(typeImage)
        typeImage.translatesAutoresizingMaskIntoConstraints = false
        typeImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        typeImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 25).isActive = true
        
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
