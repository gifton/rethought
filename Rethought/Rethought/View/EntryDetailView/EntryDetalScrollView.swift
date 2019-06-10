
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
    lazy private var titleField = UITextView()
    lazy private var detailField = UITextView()
    
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
        insertSubview(bar, at: 1000)
        
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
        
        // set view corrosponding to builder type
        switch builder.type {
        case .note: buildNote()
        case .link: buildLink()
        case .photo: buildPhoto()
        case .recording: buildRecording()
        default: return
        }
    }
    
    private func buildNote() {
        
        // check noteBuilder is present
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
        insertSubview(detailField, at: 1)
        
        // set anchors
        NSLayoutConstraint.activate( [
            titleField.heightAnchor.constraint(greaterThanOrEqualToConstant: 95),
            titleField.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            titleField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30),
            titleField.widthAnchor.constraint(equalToConstant: frame.width - 100),
            detailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            detailField.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            detailField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 25),
            detailField.widthAnchor.constraint(equalToConstant: frame.width - 90)
        ])
    }
    private func buildPhoto() {
        // check photoBuilder is present
        guard var photoBuilder: PhotoBuilder = builder as? PhotoBuilder else { return }
        //set photoN=Builder photoHeight for calculation
        photoBuilder.setHeight(forPhotoWidth: frame.width - 90)
        // create, style and set photoview
        let photoView = UIImageView()
        photoView.image = photoBuilder.photo
        photoView.contentMode = .scaleAspectFit
        photoView.frame = CGRect(x: 45, y: 150, width: frame.width - 90, height: photoBuilder.photoHeight)
        photoView.layer.cornerRadius = 10
        photoView.layer.masksToBounds = true
        
        // set detailField
        detailField.font = detailFont
        detailField.text = photoBuilder.userDetail
        detailField.translatesAutoresizingMaskIntoConstraints = false
        detailField.delegate = self
        
        // add subviews
        // detail field at 1 to stay below EntryActionBar
        addSubview(photoView)
        insertSubview(detailField, at: 1)
        
        // set constraints
        NSLayoutConstraint.activate([
            detailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            detailField.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            detailField.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 10),
            detailField.widthAnchor.constraint(equalToConstant: frame.width - 90)
        ])
    }
    private func buildLink() {
        print("building link")
        // check photoBuilder is present
        guard let linkBuilder: LinkBuilder = builder as? LinkBuilder else { return }
        // create objects - link, linkImage, title, detail
        let linkgImage = UIImageView()
        let linkURL = UILabel()
        let linkTitle = UILabel()
        let linkDetail = UILabel()
        
        // style
        linkgImage.contentMode = .scaleAspectFit
        linkURL.font = titleFont
        linkTitle.font = detailFont
        linkDetail.font = detailFont
        linkDetail.numberOfLines = 0
        // add context from preview
        guard let iconURL = linkBuilder.rawIconUrl else { return }
        guard let imgURL = URL(string: iconURL) else { return }
        linkgImage.download(from: imgURL)
        linkURL.text = linkBuilder.link
        linkDetail.text = linkBuilder.detail
        linkTitle.text = linkBuilder.title
        
        // set objects
        linkgImage.frame = CGRect(x: 45, y: 150, width: 55, height: 55)
        linkTitle.frame = CGRect(x: 45, y: 225, width: frame.width - 90, height: 35)
        linkURL.frame = CGRect(x: 120, y: 160, width: frame.width - 165, height: 35)
        linkDetail.frame = CGRect(x: 45, y: 250, width: frame.width - 90, height: 70)
        // add to superview
        addSubview(linkgImage)
        addSubview(linkTitle)
        addSubview(linkURL)
        addSubview(linkDetail)
    }
    private func buildRecording() { print("building note") }
}

extension EntryDetailScrollView: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        print("text is changing")
    }
}
