import Foundation
import UIKit

class TopRootThoughtCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewStyle()
        setViewComponents()
        
    }
    
    public static var identifier: String {
        return "TopRootThoughtCell"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainImage = UIImageView()
    let thoughtTitle = UILabel()
    let icon = UILabel()
    let entryCount = UILabel()
    let location = UILabel()
    
    func setViewStyle() {
        layer.cornerRadius = 15
        backgroundColor = .white
    }
    
    func addContext(with preview: ThoughtPreview) {
        rawTitle = preview.title
        rawIcon = preview.icon
        entCount = preview.entryCount
        rawImg = preview.recentImage
        
        addContext()
    }
    
    var rawImg: UIImage?
    var rawTitle: String?
    var rawIcon: String?
    var entCount: EntryCount?
    var rawLocation: String = "Seattle, Washington"
    
    private func setViewComponents() {
        
        addSubview(mainImage)
        addSubview(thoughtTitle)
        addSubview(icon)
        addSubview(entryCount)
        addSubview(location)
        
        mainImage.frame = CGRect(x: 10, y: 10, width: 110, height: frame.height - 20)
        thoughtTitle.frame = CGRect(x: 145, y: 10, width: 136, height: 75)
        icon.frame = CGRect(x: 145, y: 85, width: 25, height: 35)
        entryCount.frame = CGRect(x: 145, y: 110, width: 150, height: 25)
        location.frame = CGRect(x: 145, y: 125, width: 150, height: 25)
        styleComponents()
        
    }
    
    private func addContext() {
        thoughtTitle.text = rawTitle!
        icon.text = rawIcon!
        entryCount.text = "\(entCount!.total) entries"
        location.text = rawLocation
        mainImage.image = rawImg
    }
    
    private func styleComponents() {
        
        mainImage.contentMode = .scaleAspectFill
        mainImage.layer.cornerRadius = 10
        mainImage.layer.masksToBounds = true
        
        thoughtTitle.font = .boldSystemFont(ofSize: 20)
        thoughtTitle.numberOfLines = 0
        
        icon.font = .boldSystemFont(ofSize: Device.fontSize.xXLarge.rawValue)
        
        entryCount.font = Device.font.lightBody(ofSize: Device.fontSize.small)
        entryCount.textColor = .lightGray
        
        location.font = Device.font.lightBody(ofSize: Device.fontSize.small)
    }
    
    override func prepareForReuse() {
        self.mainImage.image = UIImage()
    }
}
