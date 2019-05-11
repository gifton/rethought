
import Foundation
import UIKit

class MSGBoardLinkView: MSGBoardComponent {
    
    // MSGBoardComponent typr
    var entryType: EntryType {
        return .link
    }
    
    init(frame: CGRect, lb: LinkBuilder) {
        
        //calculate height of view
        let size = lb.title.sizeFor(font: Device.font.mediumTitle(ofSize: .large), width: Device.size.width * 0.71).height + 30
        if size < 95 {
            super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: Device.size.width * 0.701, height: 95))
        } else {
            super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: Device.size.width * 0.701, height: size))
        }
        
        setViews()
        styleViews()
        
        // set linkBuilder content
        // if there is no rawURL set image to placeholder
        if let rawURL = lb.rawIconUrl {
            if let url = URL(string: rawURL) {
                linkImageView.download(from: url)
            } else {
                linkImageView.image = #imageLiteral(resourceName: "Link_light")
            }
        } else {
            linkImageView.image = #imageLiteral(resourceName: "Link_light")
        }
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        titleLabel.text = lb.title
        descriptionLabel.text = lb.userDetail
    }
    
    private let linkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    
    private func setViews() {
        backgroundColor = .white
        
        addSubview(linkImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        linkImageView.setHeightWidth(width: 65, height: 65)
        linkImageView.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 15, paddingLeading: 15)
        
        titleLabel.setTopAndLeading(top: linkImageView.topAnchor, leading: linkImageView.trailingAnchor, paddingTop: 0, paddingLeading: 5)
        titleLabel.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -5).isActive = true
        
        descriptionLabel.setAnchor(top: titleLabel.bottomAnchor, leading: linkImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 0, paddingTrailing: -5)
        
        layoutIfNeeded()
    }
    
    private func styleViews() {
        linkImageView.layer.cornerRadius = 18
        linkImageView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        linkImageView.layer.masksToBounds = true
        linkImageView.image?.scaled(toHeight: 20)
        
        titleLabel.font = Device.font.title(ofSize: .large)
        titleLabel.text = "No title available"
        
        descriptionLabel.font = Device.font.body(ofSize: .medium)
        descriptionLabel.text = "no detail available"
        descriptionLabel.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
