
import Foundation
import UIKit

class HomeLinkTile: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private objects
    private let bottomView = UIView()
    private let thoughtIconLabel = UILabel()
    private let dateLabel = UILabel()
    private let linkIcon = UIImageView()
    private let linkIconBackDrop = UIView()
    
    
    private func setView() {
        backgroundColor = .blue
        layer.cornerRadius = 10
    }
}

extension HomeLinkTile: BuilderContext {
    func addContext(_ builder: EntryBuilder) {
        guard let linkBuilder: LinkBuilder = builder as? LinkBuilder else {
            setEmptyView()
            return
        }
        
        thoughtIconLabel.text = linkBuilder.thoughtIcon.icon
        dateLabel.getStringFromDate(date: linkBuilder.date, withStyle: .short)
        
    }
    
    private func setEmptyView() {
        
    }
}
