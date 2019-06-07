
import Foundation
import UIKit

class EntryDetailScrollView: UIScrollView {
    init(withBuilder builder: EntryBuilder) {
        self.builder = builder
        super.init(frame: Device.size.frame)
        print("entryDetailScrollView initiated")
        backgroundColor = Device.colors.lightGray
        // TODO: contentsize variation depending on entry type, and entry content  (i.e. long ass note detail)
//        contentSize = frame.size
        setSuperView()
    }
    
    // MARK: public objects
    public var builder: EntryBuilder {
        didSet {
            print("builder initiated")
            decideContent()
        }
    }
    public var entryDelegate: EntryDetailDelegate?
    
    // MARK: private objects
    private var titleFont = Device.font.mediumTitle(ofSize: .xXLarge)
    private let detailFont = Device.font.formalBodyText(ofSize: .small)
    private let auxilaryFont = Device.font.mediumTitle(ofSize: .medium)
    private var closeButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Device.colors.darkGray
        btn.layer.cornerRadius = 55.0 / 2
        let img: UIImage = #imageLiteral(resourceName: "close")
        btn.setImage(img, for: .normal)
        return btn
    }()
    private var thoughtIcon = UILabel()
    private let titleLabel  = UILabel()
    private let detailLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EntryDetailScrollView {
    private func setSuperView() {
        // frames
        closeButton.frame = CGRect(x: frame.width - 75, y: 55, width: 55, height: 55)
        thoughtIcon.frame = CGRect(x: 25, y: 55, width: 55, height: 55)
        
        // styling
        thoughtIcon.font = Device.font.title(ofSize: .emojiLG)
        thoughtIcon.textAlignment = .center
        thoughtIcon.text = builder.thoughtIcon.icon
        
        // add to subview
        addSubview(closeButton)
        addSubview(thoughtIcon)
        
        // set tap gesture actions
        closeButton.addTapGestureRecognizer {
            self.entryDelegate?.returnHome()
        }
    }
    func decideContent() {
        switch builder.type {
        case .note: buildNote()
        case .link: buildLink()
        case .photo: buildPhoto()
        case .recording: buildRecording()
        default: return
        }
    }
    
    private func buildNote() {
        
    }
    private func buildPhoto() { }
    private func buildLink() { }
    private func buildRecording() { }
}
