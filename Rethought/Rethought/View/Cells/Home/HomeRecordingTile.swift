
import Foundation
import UIKit

// size = 

class HomeRecordingTile: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setView() {
        backgroundColor = .yellow
        layer.cornerRadius = 10
    }
}
