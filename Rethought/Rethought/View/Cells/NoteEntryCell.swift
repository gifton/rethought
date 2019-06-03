
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
    
    private func setView() {
        // set frames
        
        // addSubviews
    }
    
    private func styleViews() {
        // title
        titleLabel.font = Device.font.mediumTitle(ofSize: .xXLarge)
        titleLabel.textColor = .black
        // detail
        detailLabel.font = Device.font.formalBodyText(ofSize: .small)
        detailLabel.textColor = Device.colors.darkGray
        // location
        locationLabel.font = Device.font.mediumTitle(ofSize: .medium)
        locationLabel.textColor = .black
        // date
        dateLabel.font = Device.font.mediumTitle(ofSize: .medium)
        dateLabel.textColor = .black
    }
    public func add(context preview: NoteBuilder) {
        self.preview = preview
        setContext()
    }
    
    private func setContext() {
        guard let preview = preview else { return }
        titleLabel.text = preview.title
    }
}
