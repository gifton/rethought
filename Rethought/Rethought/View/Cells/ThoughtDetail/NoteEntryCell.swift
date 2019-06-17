
import Foundation
import UIKit

class NoteEntryCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Priavte objects
    private var preview: NoteBuilder?
    private var titleLabel = UILabel()
    private var detailLabel = UILabel()
    private var locationLabel = UILabel()
    private var dateLabel = UILabel()
    
    // MARK: Private variables
    private var titleFont = Device.font.mediumTitle(ofSize: .xXLarge)
    private let detailFont = Device.font.formalBodyText(ofSize: .small)
    private let auxilaryFont = Device.font.mediumTitle(ofSize: .medium)
    
    private func setView() {
        guard let preview = preview else { return }
        
        // set frames
        let titleHeight = preview.title.sizeFor(font: titleFont, width: frame.width - 70).height
        let detailHeight = preview.detail.sizeFor(font: detailFont, width: frame.width - 70).height
        
        titleLabel.frame = CGRect(x: 20, y: 20, width: frame.width - 40, height: titleHeight)
        detailLabel.frame = CGRect(x: 20, y: titleHeight + 20 + 10, width: frame.width - 40, height: detailHeight)
        locationLabel.frame = CGRect(x: 20, y: frame.height - 35, width: frame.width / 3, height: 15)
        dateLabel.frame = CGRect(x: frame.width - 100, y: frame.height - 25, width: 100, height: 15)
        
        // addSubviews
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(dateLabel)
        addSubview(locationLabel)
        
        styleViews()
    }
    
    private func styleViews() {
        // title
        titleLabel.font = titleFont
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        // detail
        detailLabel.font = detailFont
        detailLabel.textColor = Device.colors.darkGray
        detailLabel.numberOfLines = 0
        // location
        locationLabel.font = auxilaryFont
        locationLabel.textColor = .black
        // date
        dateLabel.font = auxilaryFont
        dateLabel.textColor = .black
    }
    public func add(context preview: NoteBuilder) {
        self.preview = preview
        setContext()
        setView()
    }
    
    private func setContext() {
        guard let preview = preview else { return }
        titleLabel.text = preview.title
        detailLabel.text = preview.detail
        dateLabel.getStringFromDate(date: Date(), withStyle: .short)
        locationLabel.text = "Seattle, Washington"
    }
}
