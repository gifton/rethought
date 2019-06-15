
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
    public var collectionViewCellHeights: [CGSize] = Array(repeating: CGSize(width: Device.size.width - 20, height: 100), count: 20)
    public let cv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Device.size.width - 20, height: 90)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.allowsMultipleSelection = false
        cv.backgroundColor = Device.colors.offWhite
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        
        return cv
    }()
    public var expanded: Bool = false {
        didSet {
            print("expanded set")
            if expanded { expandButton.setTitle("collapse", for: .normal) }
            else { expandButton.setTitle("expand", for: .normal) }
        }
    }
    
    // MARK: private variables
    private let expandButton = UIButton()
    private let entryLabel = UILabel()
    
    private func setView() {
        // delegate must stay within superview to calculate
        // proper height of view as it resizes on scroll
        
        // register all possible classes in advanced
        cv.delegate = self
        cv.register(cellWithClass: HomeEntryCell.self)
        cv.register(cellWithClass: HomeLinkTile.self)
        cv.register(cellWithClass: HomePhotoTile.self)
        cv.register(cellWithClass: HomeRecordingTile.self)
        cv.register(cellWithClass: HomeNoteTile.self)
        
        addSubview(cv)
        addSubview(expandButton)
        addSubview(entryLabel)
        
        cv.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 50, paddingLeading: 0, paddingBottom: 5, paddingTrailing: 0)

        expandButton.setAnchor(top: topAnchor, leading: nil, bottom: cv.topAnchor, trailing: trailingAnchor, paddingTop: 15, paddingLeading: 0, paddingBottom: 10, paddingTrailing: 30)
        
        expandButton.setTitle("Expand", for: .normal)
        expandButton.setTitleColor(Device.colors.red, for: .normal)
        expandButton.doesEnable()
        expandButton.addTapGestureRecognizer { self.expandButtonClicked() }
        entryLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 15, paddingLeading: 20)
        entryLabel.font = Device.font.mediumTitle(ofSize: .xLarge)
        entryLabel.text = "Recent Entries"
        entryLabel.textColor = Device.colors.lightGray
        
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
    func updatepackage(withContent title: String) {
        updateTitle(withContent: title)
    }
    
    private func updateTitle(withContent string: String) {
        self.entryLabel.text = string
    }
    
    private func expandButtonClicked() {
        if expanded {
            delegate?.requestCollapse()
            expanded = false
        } else {
            delegate?.requestExpansion()
            expanded = true
        }
    }
}

extension HomeTable: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.show(entryForIndex: indexPath.row)
    }
}

extension HomeTable: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewCellHeights[indexPath.row]
    }
    
    
}
