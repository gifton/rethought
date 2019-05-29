import UIKit
public extension UISearchBar {
    
    // Clear text
    func clear() {
        text = ""
    }
    // add placeholderText
    func placeHolder(_ content: String) {
        text = content
    }
}
