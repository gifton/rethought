
import Foundation
import UIKit

class RethoughtMessageCell: UITableViewCell {
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
    
    // MARK: private objects
    private let icon: UILabel = {
        let lbl = UILabel()
        lbl.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        lbl.text = Device.defaultEmoji.icon
        lbl.backgroundColor = .white
        lbl.font = .boldSystemFont(ofSize: Device.fontSize.emojiSM.rawValue)
        
        return lbl
    }()
    private let userLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rethought"
        lbl.font = Device.font.title(ofSize: .large)
        
        return lbl
    }()
    private let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Whats on your mind?"
        lbl.font = Device.font.body(ofSize: .large)
        
        return lbl
    }()
    
    private func setViews() {
        icon.frame = CGRect(x: 2, y: 2, width: 36, height: 36)
        userLabel.frame = CGRect(x: 52, y: 0, width: frame.width - 62, height: 16)
        messageLabel.frame = CGRect(x: 52, y: 20, width: frame.width - 62, height: 16)
        
        addSubview(icon)
        addSubview(userLabel)
        addSubview(messageLabel)
    }
}
