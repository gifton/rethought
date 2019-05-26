
import Foundation
import UIKit

class EntryScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.white.withAlphaComponent(0.15)
        contentSize = CGSize(width: 525, height: 80)
        showsHorizontalScrollIndicator = false
        setView()
    }
    
    let allButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "cloud_btn")!
        btn.setTitle(" All", for: .normal)
        btn.frame.size = CGSize(width: 50, height: 25)
        btn.setImage(img, for: .normal)
        return btn
    }()
    let linkButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Links", for: .normal)
        btn.frame.size = CGSize(width: 40, height: 25)
        let img = UIImage(named: "link_btn")!
        btn.setImage(img, for: .normal)
        return btn
    }()
    let noteButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "note_btn")!
        btn.setTitle(" Notes", for: .normal)
        btn.frame.size = CGSize(width: 70, height: 25)
        btn.setImage(img, for: .normal)
        return btn
    }()
    let recordingButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "recording_btn")!
        btn.setTitle(" Recordings", for: .normal)
        btn.frame.size = CGSize(width: 100, height: 25)
        btn.setImage(img, for: .normal)
        return btn
    }()
    let photoButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "photo_btn")!
        btn.frame.size = CGSize(width: 80, height: 25)
        btn.setTitle(" Photos", for: .normal)
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    private func setView() {
        var views = [UIView]()
        for type in EntryType.exhaustiveList() {
            print("setting button of type: \(type)")
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
        
        addTapGestureRecognizer(action: action)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var type: EntryType
    private var label = UILabel()
    private var image = UIImageView()
    func setView() {
        addSubview(label)
        addSubview(image)
        
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.5).isActive = true
        
        label.text = type.rawValue
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.setAnchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
    }
}
