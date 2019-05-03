
import Foundation
import UIKit

class MSGNoteView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    private let noteTitle = UILabel()
    private let noteTextView = UITextView()
    private let cancelButton = MessageButton()
    private let textCountLabel = UILabel()
    
    
    func setView() {
        
        // translate masks
        noteTitle.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        textCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // add subviews
        addSubview(noteTitle)
        addSubview(noteTextView)
        addSubview(cancelButton)
        addSubview(textCountLabel)
        
        // set anchors
        noteTitle.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeading: 30, paddingBottom: 0, paddingTrailing: 0)
        noteTextView.setAnchor(top: noteTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 30, paddingLeading: 30, paddingBottom: 155, paddingTrailing: 35)
        cancelButton.setAnchor(top: noteTextView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 35, paddingLeading: 30, paddingBottom: 0, paddingTrailing: 0)
        textCountLabel.setAnchor(top: topAnchor, leading: nil, bottom: noteTextView.topAnchor, trailing: trailingAnchor, paddingTop: 17.5, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 35)
        
        //add sizes if necessary
        cancelButton.setHeightWidth(width: 72.5, height: 35)
        noteTitle.setHeightWidth(width: 200, height: 30)
        
        //reset layout if needed
        updateConstraintsIfNeeded()
        styleViews()
    }
    
    func styleViews() {
        // set background
        backgroundColor = Device.colors.offWhite
        noteTitle.textColor = Device.colors.lightGray
        cancelButton.backgroundColor = Device.colors.red
        noteTextView.backgroundColor = .clear
        
        // add fonts
        noteTitle.font = Device.font.title(ofSize: .xXXLarge)
        noteTextView.font = Device.font.formalBodyText()
        let attrStr = NSAttributedString(string: "cancel", attributes: [NSAttributedString.Key.font : Device.font.title(ofSize: .medium),
                                                                        NSAttributedString.Key.foregroundColor : UIColor.white])
        cancelButton.setAttributedTitle(attrStr, for: .normal)
        textCountLabel.font = Device.font.mediumTitle(ofSize: .medium)
        // add view styling
        noteTitle.text = "New Note"
        noteTextView.text = "Get to typing!"
        textCountLabel.text = "\(noteTextView.text.count)"
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.masksToBounds = true
        // add targets
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MSGNoteView: MSGCenterEntryView, MSGSubView {
    var minimumComponentsCompleted: Bool {
        return false
    }
    
    var entryType: EntryType {
        return .note
    }
}
