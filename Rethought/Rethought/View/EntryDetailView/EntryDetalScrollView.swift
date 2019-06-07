
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
    private var entryActionBar: EntryActionBar!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EntryDetailScrollView {
    private func setSuperView() {
        entryActionBar = EntryActionBar(withOrigin: CGPoint(x: 15, y: 200), thoughtIcon: builder.thoughtIcon)
        // styling
        
        // add to subview
        addSubview(entryActionBar)
        // set tap gesture actions
//        closeButton.addTapGestureRecognizer {
//            self.entryDelegate?.returnHome()
//        }
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
