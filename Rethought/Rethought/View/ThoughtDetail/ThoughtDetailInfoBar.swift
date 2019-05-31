import UIKit

class ThoughtDetailInfoBar: AnimatableView {
    var entryCount: EntryCount
    var thoughtIcon: String
    
    init(point: CGPoint, count: EntryCount, icon: String) {
        entryCount = count
        thoughtIcon = icon
        let size = CGSize(width: Device.size.width - 30, height: 69)
        super.init(frame: CGRect(origin: point, size: size))
        backgroundColor = .clear
        endAlpha = 0.0
        
        createLine(withY: 0)
        createLine(withY: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var path: UIBezierPath!
    
    func createLine(withY y: CGFloat) {
        
        let startPoint = CGPoint(x: 15, y: y)
        let endPoint = CGPoint(x: frame.width - 15, y: y)
        
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1
        
        layer.addSublayer(shapeLayer)
    }
}
