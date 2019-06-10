
import Foundation
import UIKit

// show thought added by user
class MSGThoughtView: MSGBoardComponent {
    init(frame: CGRect, title: String) {
        thoughtTitle = title
        super.init(frame: frame)
        setView()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    // MARK: private vars
    private var thoughtTitle: String
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private objects
    private var thoughtIconLabel: UITextField = {
        let lbl = UITextField()
        lbl.text = "💭"
        lbl.backgroundColor = .black
        lbl.font = Device.font.mediumTitle(ofSize: .emojiLG)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 19
        lbl.layer.masksToBounds = true
        
        return lbl
    }()
    private var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.mediumTitle(ofSize: .large)
        lbl.textColor = Device.colors.lightGray
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .right
        
        return lbl
    }()
    private var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.mediumTitle(ofSize: .large)
        lbl.sizeToFit()
        lbl.textColor = .black
        lbl.text = "Gifton"
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    // add content
    private func setView() {
        thoughtIconLabel.frame = CGRect(x: frame.width - 70, y: 0, width: 55, height: 55)
        contentLbl.text = thoughtTitle
        addSubview(thoughtIconLabel)
        addSubview(contentLbl)
        addSubview(nameLabel)
        nameLabel.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: thoughtIconLabel.leadingAnchor, paddingTop: 0, paddingLeading: 15, paddingBottom: 0, paddingTrailing: 10)
        contentLbl.setAnchor(top: nameLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: thoughtIconLabel.leadingAnchor, paddingTop: 0, paddingLeading: 15, paddingBottom: 0, paddingTrailing: 10)
    }
}
