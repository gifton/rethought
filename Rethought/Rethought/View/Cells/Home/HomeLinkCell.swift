
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
    
    
    
    
    private func setView() {
        backgroundColor = .blue
        layer.cornerRadius = 10
    }
}
