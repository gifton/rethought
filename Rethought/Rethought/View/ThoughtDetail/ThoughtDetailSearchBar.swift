
import Foundation
import UIKit

class ThoughtDetailSearchBar: AnimatableView {
    init(startFrame: CGRect, endFrame: CGRect, preview: ThoughtPreview) {
        super.init(frame: startFrame)
        self.startFrame = startFrame
        self.endFrame = endFrame
        tf.text = preview.icon
    }
    
    public var delegate: ThoughtDetailDelegate! {
        didSet {
            setView()
        }
    }
    
    
    let tf: UITextField = {
        let tf = UITextField()
        tf.font = Device.font.body(ofSize: .emojiSM)
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        
        return tf
    }()
    
    let sb: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .clear
        sb.backgroundImage = UIImage()
        sb.showsCancelButton = true
        
        return sb
    }()
    
    private func setView() {
        
        backgroundColor = Device.colors.blue
        
        sb.delegate = self
        
        addSubview(tf)
        addSubview(sb)
        
        tf.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 45, paddingLeading: 25)
        tf.setHeightWidth(width: 40, height: 40)
        tf.delegate = self
        
        sb.setAnchor(top: topAnchor, leading: tf.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 50, paddingLeading: 40, paddingBottom: 15, paddingTrailing: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ThoughtDetailSearchBar: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("begin search from thoughtSearchBar")
        delegate.search(for: searchBar.text ?? "")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        delegate?.endSearch()
    }
}

extension ThoughtDetailSearchBar: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate.updateIcon(to: textField.text ?? "")
        return true
    }
}
