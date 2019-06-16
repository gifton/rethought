
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
    
    // MARK: private objects
    private var linkView: EntryButton!
    private var photoView: EntryButton!
    private var noteView: EntryButton!
    private var recordingView: EntryButton!
    private var allView: EntryButton!
    
    // MARK: public variables
    public var homeDelegate: HomeDelegate?
    public var currentType: EntryType = .all
    
    private func setView() {
        var views = [UIView]()
        for type in EntryType.exhaustiveList().reversed() {
            let btn = EntryButton(type: type) {
                self.homeDelegate?.didSelectEntryType(ofType: type)
            }
            switch type {
            case .link: linkView = btn
            case .photo: photoView = btn
            case .note: noteView = btn
            case .recording: recordingView = btn
            case .all: allView = btn
            default: ()
            }
            views.append(btn)
        }
        allView.isSelected()
        let stack = UIStackView(arrangedSubviews: views,
                                axis: .horizontal,
                                spacing: 25, alignment: .fill, distribution: .fillEqually)
        stack.frame = CGRect(x: 15, y: 15, width: contentSize.width - 30, height: 53)
        addSubview(stack)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // call from controller
    public func setSelectedEntry(ofType type: EntryType) {
        // check if type is same, if so return
        if type == currentType {
            return
        }
        
        // remove current border
        switch currentType {
        case .link: linkView.isDeselected()
        case .photo: photoView.isDeselected()
        case .recording: recordingView.isDeselected()
        case .note: noteView.isDeselected()
        case .all: allView.isDeselected()
        default: return
        }
        // add new border
        switch type {
        case .link: linkView.isSelected()
        case .photo: photoView.isSelected()
        case .recording: recordingView.isSelected()
        case .note: noteView.isSelected()
        case .all: allView.isSelected()
        default: return
        }
        // set new entry type
        currentType = type
    }
}


class EntryButton: UIView {
    // depending on entrytype, set image and framing
    init(type: EntryType, action: @escaping () -> ()) {
        var frame = CGRect(origin: .zero, size: .zero)
        switch type {
        case .note:
            frame = CGRect(origin: .zero, size: CGSize(width: 53, height: 42.5))
            image.image = #imageLiteral(resourceName: "newNote")
            image.setHeightWidth(width: 25, height: 25)
        case .link:
            frame = CGRect(origin: .zero, size: CGSize(width: 32, height: 55.5))
            image.image = #imageLiteral(resourceName: "link_btn")
            image.setHeightWidth(width: 25, height: 25)
        case .recording:
            frame = CGRect(origin: .zero, size: CGSize(width: 75, height: 53.5))
            image.image = #imageLiteral(resourceName: "recordings button")
            image.setHeightWidth(width: 17, height: 25)
        case .all:
            frame = CGRect(origin: .zero, size: CGSize(width: 75, height: 53.5))
            image.image = #imageLiteral(resourceName: "cloud_white")
            image.setHeightWidth(width: 25, height: 17)
        default:
            frame = CGRect(origin: .zero, size: CGSize(width: 51, height: 55.5))
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
        
        if type == .recording {
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
            image.topAnchor.constraint(equalTo: topAnchor, constant: 2.5).isActive = true
        } else {
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
            image.topAnchor.constraint(equalTo: topAnchor, constant: 2.5).isActive = true
        }
        
        label.text = type.rawValue
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
    }
    // borders to be added and removed
    var borders = [UIView]()
    public func isSelected() {
        label.textColor = .black
        switch type {
        case .link: image.image = #imageLiteral(resourceName: "compass_gradient")
        case .photo: image.image = #imageLiteral(resourceName: "Image_gradient")
        case .note: image.image = #imageLiteral(resourceName: "note_gradient")
        case .recording: image.image = #imageLiteral(resourceName: "microphone_gradient")
        default: image.image = #imageLiteral(resourceName: "cloud_gradient")
        }
    }
    
    public func isDeselected() {
        label.textColor = .white
        switch type {
        case .note: image.image = #imageLiteral(resourceName: "newNote")
        case .link: image.image = #imageLiteral(resourceName: "link_btn")
        case .recording: image.image = #imageLiteral(resourceName: "recordings button")
        case .all: image.image = #imageLiteral(resourceName: "cloud_white")
        default: image.image = #imageLiteral(resourceName: "photo_btn")
        }
    }
}
