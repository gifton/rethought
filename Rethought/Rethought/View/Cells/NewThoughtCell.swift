
import Foundation
import UIKit

class NewThoughtCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var identifier: String {
        return "RethoughtMessageCell"
    }
    
    let icon: UILabel = {
        let lbl = UILabel()
        lbl.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        lbl.text = Device.defaultEmoji.icon
        lbl.backgroundColor = .white
        lbl.font = .boldSystemFont(ofSize: Device.fontSize.emojiLG.rawValue)
        
        return lbl
    }()
    
    let thoughtTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Whats on your mind?"
        lbl.font = Device.font.body(ofSize: .large)
        
        return lbl
    }()
    
    public func addContext(withPreview preview: ThoughtPreview) {
        thoughtTitleLabel.text = preview.title
        icon.text = preview.icon
    }
    
    private func setViews() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        thoughtTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(icon)
        addSubview(thoughtTitleLabel)
        
        icon.setAnchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 15)
        thoughtTitleLabel.setAnchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: icon.leadingAnchor, paddingTop: 8, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 10)
        
        
    }
}
