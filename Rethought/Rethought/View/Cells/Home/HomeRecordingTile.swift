
import Foundation
import UIKit

class HomeRecordingTile: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setView() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
}
