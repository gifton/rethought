
import Foundation
import UIKit


class SearchHeadView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView(); styleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: public objects
    public var delegate: SearchViewModelDelegate?
    public let searchField: UITextView = {
        let tv = UITextView()
        tv.addDoneButtonOnKeyboard()
        tv.font = Device.font.title(ofSize: .emojiLG)
        tv.textColor = Device.colors.lightGray
        tv.isEditable = true
        tv.text = "Search"
        tv.backgroundColor = Device.colors.offWhite
        
        return tv
    }()
    
    // MARK: private variables
    private let entryLabelFrame = CGRect(x: 145, y: 210, width: 65, height: 50)
    private let thoughtLabelFrame = CGRect(x: 25, y: 210, width: 85, height: 50)
    private let searchTypeIndicatorSize = CGSize(width: 8, height: 8)
    private var currentSearchType: SearchType = .thought {
        didSet {
            didChangeSearchType(toType: currentSearchType)
        }
    }
    
    // MARK: private objects
    private let searchTypeIndicator = UIView()
    private let entryLabel = UILabel()
    private let thoughtLabel = UILabel()
    
    private func setView() {
        
        searchField.frame = CGRect(x: 25, y: 100, width: 250, height: 50)
        searchField.delegate = self
        
        entryLabel.frame = entryLabelFrame
        thoughtLabel.frame = thoughtLabelFrame
        
        searchTypeIndicator.frame = CGRect(origin: CGPoint(x: thoughtLabelFrame.origin.x, y: thoughtLabelFrame.bottom - 5), size: searchTypeIndicatorSize)
        
        entryLabel.addTapGestureRecognizer { self.selectedSearchType(type: .entry) }
        thoughtLabel.addTapGestureRecognizer { self.selectedSearchType(type: .thought) }
        
        addSubview(entryLabel)
        addSubview(thoughtLabel)
        addSubview(searchField)
        addSubview(searchTypeIndicator)
    }
    
    private func styleView() {
        layer.backgroundColor = Device.colors.offWhite.cgColor
        entryLabel.text = "entries"
        entryLabel.font = Device.font.body()
        
        thoughtLabel.font = Device.font.body()
        thoughtLabel.text = "thoughts"
        
        searchTypeIndicator.backgroundColor = .black
        searchTypeIndicator.layer.cornerRadius = searchTypeIndicatorSize.width / 2
    }
    
    private func selectedSearchType(type: SearchType) {
        if type == currentSearchType { searchTypeIndicator.addBounceAnimation(); return }
        
        switch type {
        case .thought:
            animateIndicatorTo(origin: CGPoint(x: thoughtLabelFrame.origin.x,
                                               y: thoughtLabelFrame.bottom - 5))
        case .entry:
            animateIndicatorTo(origin: CGPoint(x: entryLabelFrame.origin.x,
                                               y: entryLabelFrame.bottom - 5))
        }
        currentSearchType = type
    }
    
    private func animateIndicatorTo(origin: CGPoint) {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1.25, initialSpringVelocity: 2.2, options: .curveEaseIn, animations: {
            self.searchTypeIndicator.frame.origin = origin
        }) { (true) in
            print("moved thought to: \(self.currentSearchType)")
        }
    }
    
    private func didChangeSearchType(toType type: SearchType) {
        guard let delegate = delegate else { return }
        if type == delegate.searchingForEntries { return }
        else { delegate.setSearchEntryType(type) }
    }
    
}

extension SearchHeadView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Search"
        }
    }
    
}
