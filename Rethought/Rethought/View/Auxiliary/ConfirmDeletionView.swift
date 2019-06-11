
import Foundation
import UIKit

class ConfirmDeletionView: UIView {
    init(thought: ThoughtPreview, point: CGPoint) {
        icon = thought.icon
        super.init(frame: CGRect(origin: point, size: CGSize(width: 200, height: 300)))
        backgroundColor = Device.colors.offWhite
        layer.masksToBounds = true
        layer.cornerRadius = 12
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private vars
    let icon: String
    public let deleteButton = UIButton()
    public let closeButton = UIButton()
    
    func setView() {
        let confirmLabel = UILabel()
        confirmLabel.text = "Are you sure you want to delete this thought?"
        confirmLabel.font = Device.font.body(ofSize: .large)
        confirmLabel.frame = CGRect(x: 10, y: 40, width: frame.width - 20, height: 65)
        confirmLabel.numberOfLines = 0
        addSubview(confirmLabel)
        
        deleteButton.frame = CGRect(x: 0, y: frame.height - 55, width: frame.width, height: 55)
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = Device.colors.red
        
        closeButton.frame = CGRect(x: frame.width - 50, y: 5, width: 35, height: 35)
        closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        addSubview(closeButton)
        addSubview(deleteButton)
    }
}
