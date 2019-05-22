
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
    let typelbl = UILabel()
    
    func setCell() {
        addSubview(cell)
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .white
        cell.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 10, paddingBottom: 5, paddingTrailing: 10)
        
        setViews()
    }
    
    public func insert(payload entry: Entry) {
        self.entry = entry
        typelbl.text = "\(entry.type)"
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
        cell.addSubview(typelbl)
        
        moreBtn.setImage(#imageLiteral(resourceName: "more"), for: .normal)
        moreBtn.frame = CGRect(x: frame.width + 25, y: 30, width: 10, height: 30)
        typelbl.frame = CGRect(x: 50, y: 15, width: frame.width - 75, height: 30)
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
