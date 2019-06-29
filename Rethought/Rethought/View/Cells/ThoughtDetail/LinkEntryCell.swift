
import Foundation
import UIKit

class LinkEntryCell: UITableViewCell {
    
    // MARK: private objects
    private var locationLabel = UILabel()
    private var dateLabel = UILabel()
    private var iconView = UIImageView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    
    // MARK: private vars
    private var preview: LinkBuilder!
    private let auxilaryFont = Device.font.mediumTitle(ofSize: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func add(content payload: LinkBuilder) {
        preview = payload
        setView()
        styleView()
        setContext()
    }
    
    private func setView() {
        // set frames
        iconView.frame = CGRect(x: 20, y: 35, width: 30, height: 30)
        titleLabel.frame = CGRect(x: 60, y: 35, width: frame.width - 70, height: 19)
        detailLabel.frame = CGRect(x: 60, y: 60, width: frame.width - 70, height: 19)
        locationLabel.frame = CGRect(x: 20, y: frame.height - 25, width: frame.width / 3, height: 17)
        dateLabel.frame = CGRect(x: frame.width - 100, y: frame.height - 25, width: 100, height: 17)
        
        // addSubview
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(detailLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
    }
    
    private func styleView() {
        // icon label
        iconView.contentMode = .scaleAspectFit
        // title label
        titleLabel.font = Device.font.title(ofSize: .large)
        titleLabel.textColor = .black
        // detail label
        detailLabel.font = Device.font.mediumTitle(ofSize: .medium)
        detailLabel.textColor = Device.colors.darkGray
        // location
        locationLabel.font = auxilaryFont
        locationLabel.textColor = .black
        // date
        dateLabel.font = auxilaryFont
        dateLabel.textColor = .black
        
    }
    
    private func setContext() {
        guard let preview = preview else { return }
        titleLabel.text = preview.title
        detailLabel.text = preview.detail
        guard let rawURL = preview.rawIconUrl else {
            print("counldnt get icon url string")
            imageView?.image = #imageLiteral(resourceName: "link_clay")
            return
        }
        guard let url = URL(string: rawURL) else {
            print("counldnt get icon")
            imageView?.image = #imageLiteral(resourceName: "link_clay")
            return
        }
        iconView.download(from: url)
        
        dateLabel.getStringFromDate(date: preview.date, withStyle: .short)
        locationLabel.text = "Seattle, Washington"
    }
}
