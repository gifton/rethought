import UIKit

class ThoughtDetailInfoBar: AnimatableView {
    
    // MARK: Private objects
    private var block: EntryCountBlock
    private var entryCount: EntryCount
    
    // MARK: Private variables
    private var thoughtIcon: String
    
    init(point: CGPoint, count: EntryCount, icon: String) {
        entryCount = count
        thoughtIcon = icon
        let size = CGSize(width: Device.size.width - 30, height: 69)
        block = EntryCountBlock(withCount: count, frame: CGRect(x: 15, y: 15, width: 120, height: 35))
        block.dark = true
    
        super.init(frame: CGRect(origin: point, size: size))
        backgroundColor = .clear
        endAlpha = 0.0
        
        addSubview(block)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
