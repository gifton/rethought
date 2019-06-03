
import Foundation
import UIKit

class HomeHead: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = startBGColor
        setView(); styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK animation variables
    //floats
    private let startHeight = CGFloat(500)
    let endHeight = CGFloat(170)
    //colors
    private let startBGColor = UIColor(hex: "#5FA4EF")
    private let finishBGColor = UIColor(hex: "#4C3EC1")
    private let dateTextColorStart = UIColor.white
    private let dateTextColorFinish = Device.colors.yellow
    
    //frames
    private let dateStartFrame = CGRect(x: 25, y: 90, width: 200, height: 18)
    private var dateEndFrame = CGRect(x: 225, y: 65, width: 200, height: 18)
    
    // labels
    private let rethoughtLabel = AnimatableLabel()
    public let dateLabel = AnimatableLabel()
    
    // horizontally scrolling collectionView
    public let thoughtCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 170)
        layout.minimumLineSpacing = 15
        
        let cv = UICollectionView(frame: CGRect(x: 5, y: 190, width: Device.size.width - 10, height: 170), collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    // select specific entry types here
    private let entryPickerView = EntryScrollView(frame: .zero)
    
    private func setView() {
        
        // set collection
        thoughtCollection.register(cellWithClass: ThoughtCollectionCell.self)
        
        // add subviews
        addSubview(thoughtCollection)
        addSubview(rethoughtLabel)
        addSubview(dateLabel)
        addSubview(entryPickerView)
        
        // set frames
        rethoughtLabel.frame = CGRect(x: 25, y: 50, width: 200, height: 42)
        dateLabel.frame = dateStartFrame
        entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
    }
    
    private func styleView() {
        rethoughtLabel.text = "Rethought"
        rethoughtLabel.font = Device.font.title(ofSize: .emojiLG)
        rethoughtLabel.textColor = .white
        
        dateLabel.startColor = dateTextColorStart
        dateLabel.endColor = dateTextColorFinish
        dateLabel.startFrame = dateStartFrame
        dateLabel.endFrame = dateEndFrame
        dateLabel.getStringFromDate(date: Date(), withStyle: .full)
        dateLabel.textColor = .white
        dateLabel.font = Device.font.body(ofSize: .medium)
        
        thoughtCollection.backgroundColor = .clear
    }
}

extension HomeHead: Animatable {
    
    func update(toAnimationProgress progress: CGFloat) {
        
        //calculate height delta from progress
        let newHeight: CGFloat = ((startHeight - endHeight) * progress)
        frame.size.height = startHeight - newHeight
        
        entryPickerView.frame = CGRect(x: 0, y: frame.height - 80, width: frame.width, height: 80)
        
        thoughtCollection.alpha = (1 - progress * 2)
        
        dateLabel.update(toAnimationProgress: progress)
        
        backgroundColor = startBGColor.animate(toColor: finishBGColor, withProgress: progress)
    }
}
