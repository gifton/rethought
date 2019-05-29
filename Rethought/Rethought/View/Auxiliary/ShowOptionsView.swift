
import Foundation
import UIKit

// selecting, deleting view pop up from bottom on selection
class ShowOptionsView: UIView {
    init(frame: CGRect, options: [OptionViewActions]) {
        self.options = options
        super.init(frame: frame)
        
        backgroundColor = Device.colors.offWhite
        setViews()
        
    }
    // MARK: Private variables
    private var options: [OptionViewActions]
    public let cancelButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: Device.size.width - 55, y: 25, width: 25, height: 25)
        btn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        
        return btn
    }()
    private var allViews: [UIView] {
        var views = [UIView]()
        for option in options {
            views.append(createView(ofType: option))
        }
        
        return views
    }
    
    // set initial views
    private func setViews() {
        var startPoint = CGPoint(x: 20, y: 20)
        let spacing: CGFloat = 10
        for cView in allViews {
            addSubview(cView)
            cView.frame.origin = startPoint
            
            startPoint = CGPoint(x: startPoint.x, y: startPoint.y + cView.frame.height + spacing)
        }
        
        addSubview(cancelButton)
    }
    
    // produce single view for entry type
    private func createView(ofType type: OptionViewActions) -> UIView {
        switch type {
        case .toEntry:
            // to entry
            let lbl = UILabel(frame: CGRect(origin: CGPoint(x: 25, y: 0), size: CGSize(width: frame.width - 50, height: 31)))
            lbl.text = "Go to Entry"
            lbl.font = Device.font.mediumTitle(ofSize: .large)
            lbl.addBorders(edges: [.bottom], color: UIColor(hex: "D8D8D8"), thickness: 0.5)
            lbl.textColor = Device.colors.darkGray
            
            return lbl
        case .toThought:
            // to thought
            let lbl = UILabel(frame: CGRect(origin: CGPoint(x: 25, y: 0), size: CGSize(width: frame.width - 50, height: 31)))
            lbl.text = "Go to Thought"
            lbl.font = Device.font.mediumTitle(ofSize: .large)
            lbl.addBorders(edges: [.bottom], color: UIColor(hex: "D8D8D8"), thickness: 0.5)
            lbl.textColor = Device.colors.darkGray
            
            return lbl
        default:
            //delete
            let view = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 35)))
            view.layer.cornerRadius = 8
            view.setTitle("delete", for: .normal)
            view.backgroundColor = Device.colors.red
            
            return view
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum OptionViewActions {
    case delete, toThought, toEntry
}
