
import Foundation
import UIKit

class MSGBoardPhotoView: MSGBoardComponent {
    init(frame: CGRect, payload: PhotoBuilder) {
        builder = payload
        
        // calculate height
        // 10pts for padding below image, 15 pts for bottom of label
        let lblSize = builder.userDetail.sizeFor(font: Device.font.body(ofSize: .small ), width: Device.size.newImageBoardView.width)
        let height: CGFloat = Device.size.newImageBoardView.height + lblSize.height + 25
        
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: Device.size.newNoteBoardView, height: height))
        backgroundColor = .white
        self.roundCorners([.allCorners], radius: 14)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var detailLbl = UILabel()
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.backgroundColor = Device.colors.yellow
        
        return iv
    }()
    
    private func setView() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        detailLbl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(detailLbl)
        
        imageView.setHeightWidth(width: Device.size.newImageBoardView.width, height: Device.size.newImageBoardView.height)
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        detailLbl.setAnchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 5, paddingBottom: 15, paddingTrailing: 5)
        
        styleView()
    }
    
    private func styleView() {
        imageView.image = builder.photo
        detailLbl.text = builder.userDetail
        detailLbl.numberOfLines = 0
    }
    
    var builder: PhotoBuilder
}
