
import Foundation
import UIKit

class EntryDetailScrollView: UIScrollView {
    init(withBuilder builder: EntryBuilder) {
        self.builder = builder
        super.init(frame: Device.size.frame)
        showsVerticalScrollIndicator = false
        backgroundColor = .white
        // TODO: contentsize variation depending on entry type, and entry content  (i.e. long ass note detail)
        contentSize = CGSize(width: frame.width, height: frame.height + 15)
        setSuperView()
        decideContent()
    }
    
    // MARK: public objects
    public var builder: EntryBuilder
    public var entryDelegate: EntryDetailDelegate?
    
    // MARK: private vars
    private var titleFont = Device.font.mediumTitle(ofSize: .xXLarge)
    private let detailFont = Device.font.formalBodyText(ofSize: .small)
    private let auxilaryFont = Device.font.mediumTitle(ofSize: .medium)
    
    // MARK: private objects
    private var entryActionBar: EntryActionBar!
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private var titleField = UITextView()
    private var detailField = UITextView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EntryDetailScrollView {
    private func setSuperView() {
        // set entryActionBar
        entryActionBar = EntryActionBar(withOrigin: CGPoint(x: 15, y: frame.height - 150), thoughtIcon: builder.thoughtIcon)
        let bar = UIView(frame: CGRect(x: 45, y: 100, width: frame.width - 90, height: 1))
        bar.layer.cornerRadius = 0.5
        bar.backgroundColor = .black
        // add to subview
        addSubview(entryActionBar)
        addSubview(dateLabel)
        addSubview(locationLabel)
        addSubview(bar)
        
        // styling
        locationLabel.font = auxilaryFont
        locationLabel.text = "Seattle, Washington"
        dateLabel.getStringFromDate(date: Date(), withStyle: .short)
        dateLabel.font = auxilaryFont
        
        // frames
        locationLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 80, paddingLeading: 45)
        dateLabel.setTopAndLeading(top: topAnchor, leading: locationLabel.trailingAnchor, paddingTop: 80, paddingLeading: 100)
        // set tap gesture actions
        entryActionBar.closeButton.addTapGestureRecognizer {
            self.entryDelegate?.returnHome()
        }
    }
    func decideContent() {
        // tell text views to clear content before redisplaying
        titleField.clearsContextBeforeDrawing = true
        detailField.clearsContextBeforeDrawing = true
        
        switch builder.type {
        case .note: buildNote()
        case .link: buildLink()
        case .photo: buildPhoto()
        case .recording: buildRecording()
        default: return
        }
    }
    
    private func buildNote() {
        
        // guard into note
        guard let note: NoteBuilder = builder as? NoteBuilder else { return }
        
        // style textViews
        titleField.font = titleFont
        titleField.delegate = self
        detailField.delegate = self
        detailField.font = detailFont
        titleField.translatesAutoresizingMaskIntoConstraints = false
        detailField.translatesAutoresizingMaskIntoConstraints = false
        
        // add content
        titleField.text = note.title
        detailField.text = note.detail
        
        // add to view
        addSubview(titleField)
        addSubview(detailField)
        
        // set anchors
        NSLayoutConstraint.activate( [
            titleField.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            titleField.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            titleField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50),
            titleField.widthAnchor.constraint(equalToConstant: frame.width - 90),
            detailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
            detailField.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            detailField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            detailField.widthAnchor.constraint(equalToConstant: frame.width - 90)
        ])
    }
    private func buildPhoto() {
        print("building photo")
        guard var photoBuilder: PhotoBuilder = builder as? PhotoBuilder else { return }
        photoBuilder.setHeight(forPhotoWidth: frame.width - 90)
        let photoView = UIImageView()
        photoView.image = photoBuilder.photo
        photoView.contentMode = .scaleAspectFit
        photoView.frame = CGRect(x: 45, y: 150, width: frame.width - 90, height: photoBuilder.photoHeight)
        photoView.layer.cornerRadius = 10
        photoView.layer.masksToBounds = true
        
        addSubview(photoView)
    }
    private func buildLink() { print("building link") }
    private func buildRecording() { print("building note") }
}

extension EntryDetailScrollView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print("text is changing")
    }
}
