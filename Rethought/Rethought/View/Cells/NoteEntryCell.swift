
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
    private var preview: ThoughtPreview?
    private var titleLabel = UILabel()
    private var detailLabel = UILabel()
    private var locationLabel = UILabel()
    private var dateLabel = UILabel()
}
