
import Foundation
import UIKit

public class ReTabItem {
    var title: String?
    var icon: UIImage?
    var customView: UIView?
    var offset = UIOffset.zero
    public var selectable: Bool = true
    
    public init(title: String, icon:UIImage) {
        self.title = title
        self.icon = icon
    }
    public init(customView: UIView, offset: UIOffset = UIOffset.zero) {
        self.customView = customView
        self.offset = offset
    }
}
