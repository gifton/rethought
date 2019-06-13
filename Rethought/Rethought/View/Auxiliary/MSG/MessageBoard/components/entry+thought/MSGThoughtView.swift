
import Foundation
import UIKit

// show thought added by user
class MSGThoughtView: MSGBoardComponent {
    
    init(frame: CGRect, title: String) {
        thoughtTitle = title
        super.init(frame: frame)
        setView()
    }
    
    // MARK: private vars
    private var thoughtTitle: String
    
    // MARK: public vars
    public var actions: ThoughtUpdater?
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: private objects
    var thoughtIconField: IconView!
    private var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.mediumTitle(ofSize: .large)
        lbl.textColor = Device.colors.lightGray
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        
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
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    // add content
    private func setView() {
        
        thoughtIconField = IconView(frame: CGRect(x: frame.width - 70, y: 0, width: 55, height: 55), emoji: ThoughtIcon("💭"))
        thoughtIconField.iconDelegate = self
        contentLbl.text = thoughtTitle
        addSubview(thoughtIconField)
        addSubview(contentLbl)
        addSubview(nameLabel)
        nameLabel.setAnchor(top: topAnchor, leading: nil, bottom: nil, trailing: thoughtIconField.leadingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 10)
        contentLbl.setAnchor(top: nameLabel.bottomAnchor, leading: nil, bottom: nil, trailing: thoughtIconField.leadingAnchor, paddingTop: 0, paddingLeading: 15, paddingBottom: 0, paddingTrailing: 10)
        contentLbl.preferredMaxLayoutWidth = Device.size.width - 205
    }
}


protocol IconViewDelegate {
    func updateIcon(to icon: ThoughtIcon)
}

extension MSGThoughtView: IconViewDelegate {
    func updateIcon(to icon: ThoughtIcon) {
        print("updatingicon to: \(icon.icon)")
        actions?.updateIcon(withIcon: icon)
    }
}
