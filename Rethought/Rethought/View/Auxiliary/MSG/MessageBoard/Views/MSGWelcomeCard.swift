
import Foundation
import UIKit

class MSGWelcomeCard: MSGBoardComponent {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: 320, height: 169))
        self.backgroundColor = .white
        layer.cornerRadius = 20
        
        componentType = .welcomeCard
        setViews()
    }
    
    var backgroundImage = UIImageView(frame: CGRect(x: 30, y: 20, width: 175, height: 130))
    var titleLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 24))
    var dateLabel = UILabel(frame: CGRect(x: 100, y: 125, width: 200, height: 16))
    
    func setViews() {
        backgroundImage.image = #imageLiteral(resourceName: "welcomeCardGraphic")
        backgroundImage.contentMode = .scaleAspectFit
        
        titleLabel.textAlignment = .left
        titleLabel.text = "Start a new thought"
        titleLabel.font = Device.font.title(ofSize: .xXLarge)
        titleLabel.textColor = Device.colors.green
        
        dateLabel.textAlignment = .left
        dateLabel.font = Device.font.body(ofSize: .medium)
        dateLabel.textColor = Device.colors.darkGray
        dateLabel.getStringFromDate(date: Date(), withStyle: .medium)
        
        addSubview(backgroundImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
