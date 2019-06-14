
import Foundation
import UIKit

// horizontal scroll view that creates a new view for each button
class EntryScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentSize = CGSize(width: 525, height: 80)
        showsHorizontalScrollIndicator = false
        setView()
    }
    
    private var linkView: UIView!
    private var photoView: UIView!
    private var noteView: UIView!
    private var recordingView: UIView!
    private var allView: UIView!
    
    private func setView() {
        var views = [UIView]()
        for type in EntryType.exhaustiveList() {
            let btn = EntryButton(type: type) {
                print("selected: \(type)")
            }
            views.append(btn)
        }
        let stack = UIStackView(arrangedSubviews: views,
                                axis: .horizontal,
                                spacing: 25, alignment: .fill, distribution: .fillEqually)
        stack.frame = CGRect(x: 15, y: 15, width: contentSize.width - 30, height: 53)
        addSubview(stack)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class EntryButton: UIView {
    // depending on entrytype, set image and framing
    init(type: EntryType, action: @escaping () -> ()) {
        var frame = CGRect(origin: .zero, size: .zero)
        switch type {
        case .note:
            frame = CGRect(origin: .zero, size: CGSize(width: 53, height: 40))
            image.image = #imageLiteral(resourceName: "newNote")
            image.setHeightWidth(width: 25, height: 25)
        case .link:
            frame = CGRect(origin: .zero, size: CGSize(width: 32, height: 53))
            image.image = #imageLiteral(resourceName: "link_btn")
            image.setHeightWidth(width: 25, height: 25)
        case .recording:
            frame = CGRect(origin: .zero, size: CGSize(width: 75, height: 51))
            image.image = #imageLiteral(resourceName: "recordings button")
            image.setHeightWidth(width: 17, height: 25)
        case .all:
            frame = CGRect(origin: .zero, size: CGSize(width: 75, height: 51))
            image.image = #imageLiteral(resourceName: "cloud_white")
            image.setHeightWidth(width: 25, height: 17)
        default:
            frame = CGRect(origin: .zero, size: CGSize(width: 51, height: 53))
            image.image = #imageLiteral(resourceName: "photo_btn")
            image.setHeightWidth(width: 29.5, height: 25)
        }
        self.type = type
        super.init(frame: frame)
        
        // inject method into tap gaesture recognizer on view
        addTapGestureRecognizer(action: action)
        addTapGestureRecognizer {
            action()
            self.addBounceAnimation()
        }
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private variables
    private var type: EntryType
    private var label = UILabel()
    private var image = UIImageView()
    func setView() {
        addSubview(label)
        addSubview(image)
        
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        
        label.text = type.rawValue
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
    }
}
