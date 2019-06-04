
import Foundation
import UIKit

// view that appears at top of msgBoard
class MSGBoardWelcomeCard: MSGBoardComponent {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.backgroundColor = UIColor.clear.cgColor
        backgroundColor = UIColor.clear
        
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 320, height: 169)
        
        componentType = .welcomeCard
        
        isOpaque = true
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
        
        translatesAutoresizingMaskIntoConstraints = false
        setViews()
    }
    
    // MARK: Private objects
    private var backgroundImage = UIImageView(frame: CGRect(x: 30, y: 20, width: 175, height: 130))
    private var titleLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 24))
    private var dateLabel = UILabel(frame: CGRect(x: 100, y: 125, width: 200, height: 16))
    
    private func setViews() {
        backgroundImage.image = #imageLiteral(resourceName: "welcomeCardGraphic")
        backgroundImage.contentMode = .scaleAspectFit

        titleLabel.textAlignment = .left
        titleLabel.text = "Start a new thought"
        titleLabel.font = Device.font.title(ofSize: .xXLarge)
        titleLabel.textColor = Device.colors.blue

        dateLabel.textAlignment = .left
        dateLabel.font = Device.font.body(ofSize: .medium)
        dateLabel.textColor = Device.colors.darkGray
        dateLabel.getStringFromDate(date: Date(), withStyle: .medium)

        addSubview(backgroundImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePath()
    }
    
    //functions and variables for creating a true iphone x radius';;;'
    private var radius: CGFloat = 28.5
    private var path: UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        guard let path = path,
            let context = UIGraphicsGetCurrentContext() else {
                print("returning")
                return
        }
        
        context.clear(rect)
        UIColor.white.setFill()
        path.fill()
    }
    
    private func updatePath() {
        let path = UIBezierPath.continuousRoundedRect(bounds, cornerRadius: (topLeft: radius, topRight: radius, bottomLeft: radius, bottomRight: radius))
        
        layer.shadowPath = path.cgPath
        
        self.path = path
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
