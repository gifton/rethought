
import Foundation
import UIKit

class HomeTable: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Device.colors.offWhite
        setView()
    }
    
    // MARK: public variables
    public var animator: Animator?
    public var delegate: HomeDelegate?
    public var collectionViewCellHeights: [CGSize] = Array(repeating: CGSize(width: Device.size.width - 20, height: 100), count: 55)
    public let cv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Device.size.width - 20, height: 90)
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = false
        cv.backgroundColor = Device.colors.offWhite
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        
        return cv
    }()
    
    // MARK: private variables
    private let filterButton = UIButton()
    private let entryLabel = UILabel()
    
    private func setView() {
        // delegate must stay with scrll view to calculate
        // proper height of view as it resizes on scroll
        cv.delegate = self
        cv.register(cellWithClass: HomeEntryCell.self)
        
        addSubview(cv)
        addSubview(filterButton)
        addSubview(entryLabel)
        
        cv.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 50, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 0)

        filterButton.setAnchor(top: topAnchor, leading: nil, bottom: cv.topAnchor, trailing: trailingAnchor, paddingTop: 15, paddingLeading: 0, paddingBottom: 10, paddingTrailing: 30)
        filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        
        entryLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 15, paddingLeading: 20)
        entryLabel.font = Device.font.mediumTitle(ofSize: .xLarge)
        entryLabel.text = "Recent Entries"
        entryLabel.textColor = Device.colors.red
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has notbeen implemented")
    }
    
    // MARK: Variables for scrolling update calculations
    private let endFrame: CGFloat = 170
    private let startFrame: CGFloat = 500
    public var animationScrollLength: CGFloat = 330.0
    private var lastOffset: CGFloat = 0.0
    public var animationProgress: CGFloat {
        if cv.numberOfItems(inSection: 0) > 6 {
            let offset = cv.contentOffset.y
            let normalizedOffset = max(0.0, min(1.0, offset/animationScrollLength))
            return normalizedOffset
        }
        return 0
    }
    
    // update accordinf to animation progress
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        frame.origin.y = startFrame + ((endFrame - startFrame) * animationProgress)
        frame.size.height = (Device.size.height - frame.origin.y)
        //alert controller of movement to animate individual seperate views
        animator?.didUpdate()
    }
}

// handle when new content for table is requested
extension HomeTable: HomeContentPackageReciever {
    func updatepackage(withContent content: HomeContentPackage) {
        print(content.title)
        updateTitle(withContent: content.title)
    }
    
    private func updateTitle(withContent string: String) {
        self.entryLabel.text = string
    }
}

extension HomeTable: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.show(entryForIndex: indexPath.row)
    }
}

extension HomeTable: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0, 1, 4, 5: return CGSize(width: (collectionView.frame.width - 20) / 2, height: 190)
        default: return CGSize(width: collectionView.frame.width, height: 180)
        }
    }
}
