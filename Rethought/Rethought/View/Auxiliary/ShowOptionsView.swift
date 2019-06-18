
import Foundation
import UIKit

// selecting, deleting view pop up from bottom on selection
class ShowOptionsView: UIView {
    init(frame: CGRect, options: [OptionViewActions], delegate: HomeDelegate) {
        self.options = options
        self.delegate = delegate
        super.init(frame: frame)
        
        backgroundColor = Device.colors.offWhite
        setViews()
        
    }
    // MARK: Private variables
    private var delegate: HomeDelegate
    private var options: [OptionViewActions]
    private var allViews: [UIView] {
        var views = [UIView]()
        for option in options {
            views.append(createView(ofType: option))
        }
        
        return views
    }
    
    // MARK: public objects
    public let cancelButton: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: Device.size.width - 55, y: 25, width: 25, height: 25)
        btn.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        
        return btn
    }()
    
    public var toEntryLabel: UILabel!
    public var toThoughtLabel: UILabel!
    public var deleteButton: UIButton!
    
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
            toEntryLabel = UILabel(frame: CGRect(origin: CGPoint(x: 25, y: 0), size: CGSize(width: frame.width - 50, height: 31)))
            toEntryLabel.text = "Go to Entry"
            toEntryLabel.font = Device.font.mediumTitle(ofSize: .large)
            toEntryLabel.addBorders(edges: [.bottom], color: UIColor(hex: "D8D8D8"), thickness: 0.5)
            toEntryLabel.textColor = Device.colors.darkGray
            
            return toEntryLabel
        case .toThought:
            // to thought
            toThoughtLabel = UILabel(frame: CGRect(origin: CGPoint(x: 25, y: 0), size: CGSize(width: frame.width - 50, height: 31)))
            toThoughtLabel.text = "Go to Thought"
            toThoughtLabel.font = Device.font.mediumTitle(ofSize: .large)
            toThoughtLabel.addBorders(edges: [.bottom], color: UIColor(hex: "D8D8D8"), thickness: 0.5)
            toThoughtLabel.textColor = Device.colors.darkGray
            
            return toThoughtLabel
        default:
            //delete
            deleteButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 35)))
            deleteButton.layer.cornerRadius = 8
            deleteButton.setTitle("delete", for: .normal)
            deleteButton.backgroundColor = Device.colors.red
            
            return deleteButton
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum OptionViewActions {
    case delete, toThought, toEntry
}
