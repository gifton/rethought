
import Foundation
import UIKit

class MSGCenterNoteView: UIView {
    init(bus: EntryComponentBus) {
        self.bus = bus
        super.init(frame: .zero)
        setView()
    }
      
    var bus: EntryComponentBus
    private var newDetail: String?
    
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
        noteTextView.delegate = self
        updateConstraintsIfNeeded()
        styleViews()
    }
    
    func styleViews() {
        // set background
        // gifton
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
    
    private func cancel() {
        self.noteTextView.resignFirstResponder()
        bus.entryDidRequestCancel()
    }
    
    public func requestSave(withTitile title: String) {
        // check if all parts are added
        guard let detail = newDetail else { return }
        // if they are, hit bus.save(payload:)
        sendContent(with: title, and: detail)
        //then run completion, else dont do any of that haha
    }
    
    private func sendContent(with title: String, and detail: String) {
        let nb = NoteBuilder(detail: detail, title: title, forEntry: nil)
        bus.save(withpayload: nb)
    }
}

extension MSGCenterNoteView: MSGCenterEntryView, MSGSubView {
    var minimumComponentsCompleted: Bool {
        return !(newDetail == nil)
    }
    
    var entryType: EntryType {
        return .note
    }
}

extension MSGCenterNoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        newDetail = textView.text
        textCountLabel.text = "\(textView.text.count)"
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        
        return true
    }
    
}
