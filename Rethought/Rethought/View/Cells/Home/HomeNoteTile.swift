
import Foundation
import UIKit

class HomeNoteTile: UICollectionViewCell, BuilderContext {
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private objects
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let locationLabel = UILabel()
    private let noteIcon = UIImageView()
    
    // MARK: private variables
    private var titleFont = Device.font.mediumTitle(ofSize: .xXLarge)
    private let detailFont = Device.font.formalBodyText(ofSize: .small)
    private let auxilaryFont = Device.font.mediumTitle(ofSize: .medium)
    
    func addContext(_ builder: EntryBuilder) {
        guard let context: NoteBuilder = builder as? NoteBuilder else { return }
        
        dateLabel.getStringFromDate(date: context.date, withStyle: .short)
        titleLabel.text = context.title
        detailLabel.text = context.detail
        locationLabel.text = "Seattle, Washington"
        
        // get heights from detail and title
        let titleHeight: CGFloat = context.title.sizeFor(font: titleFont, width: frame.width - 40).height
        let detailHeight: CGFloat = context.detail.sizeFor(font: detailFont, width: frame.width - 40).height
        
        titleLabel.frame = CGRect(x: 20, y: 15, width: frame.width - 40, height: titleHeight)
        detailLabel.frame = CGRect(x: 20, y: 40 + titleHeight, width: frame.width - 40, height: detailHeight)
        
        addSubview(titleLabel)
        addSubview(detailLabel)
        setView()
        
    }
    
    private func setView() {
        // super view
        backgroundColor = .white
        layer.cornerRadius = 10
        
        // frames
        dateLabel.frame = CGRect(x: frame.width - 90, y: detailLabel.frame.origin.y + detailLabel.frame.height + 35, width: 70, height: 16)
        locationLabel.frame = CGRect(x: 20, y: detailLabel.frame.origin.y + detailLabel.frame.height + 35, width: 150, height: 16)
        noteIcon.frame = CGRect(x: frame.width - 60, y: 10, width: 30, height: 30)
        // add to subview
        
        addSubview(dateLabel)
        addSubview(locationLabel)
        addSubview(noteIcon)
    }
    
    private func styleView() {
        
        noteIcon.contentMode = .scaleAspectFit
        noteIcon.image = #imageLiteral(resourceName: "note_gradient")
        
        dateLabel.font = auxilaryFont
        locationLabel.font = auxilaryFont
        
        titleLabel.font = titleFont
        titleLabel.textColor = Device.colors.darkGray
        titleLabel.numberOfLines = 0
        
        detailLabel.numberOfLines = 0
        detailLabel.font = detailFont
    }
}
