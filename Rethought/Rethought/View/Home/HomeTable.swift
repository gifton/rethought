
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
    public var cv: UICollectionView!
    public var cvLayout: UICollectionViewFlowLayout!
    public var expanded: Bool = false {
        didSet {
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
        // create vc
        cvLayout = UICollectionViewFlowLayout()
        cvLayout.itemSize = CGSize(width: Device.size.width - 20, height: 90)
        cvLayout.minimumLineSpacing = 10
        
        cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.allowsMultipleSelection = false
        cv.backgroundColor = Device.colors.offWhite
        cv.showsVerticalScrollIndicator = false
        
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
        
        // set colleciton frames
        collectionStartFrame = CGRect(x: 0, y: 50, width: frame.width, height: frame.height - 50)
        collectionEndFrame = CGRect(x: 0, y: 50, width: frame.width, height: frame.height - 50)
        cv.frame = collectionStartFrame

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
    // collection frames are mutable because theyre calcuated at initialization time in setView() method
    private var collectionStartFrame: CGRect = .zero
    private var collectionEndFrame: CGRect = .zero
    public var animationScrollLength: CGFloat = 330.0
    private var lastOffset: CGFloat = 0.0
    public var animationProgress: CGFloat {
        if cv.numberOfItems(inSection: 0) > 7 {
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
        cv.frame.size.height = (Device.size.height - frame.origin.y) - 50
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
            expanded = false
            delegate?.requestCollapse()
        } else {
            expanded = true
            delegate?.requestExpansion()
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
        return delegate?.sizeFor(row: indexPath.row) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch expanded {
        case true: return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case false: return .zero
        }
    }
}
