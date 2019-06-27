
import Foundation
import UIKit

class MessageButton: UIButton, MSGSubView {
    var entryType: EntryType = .none
    var messageButtonType: MessageButtonType = .entry
}

extension UIButton {
    public func isDisabled() {
        layer.opacity = 0.4
        isUserInteractionEnabled = false
    }
    public func doesEnable() {
        layer.opacity = 1.0
        self.showsTouchWhenHighlighted = true
        isUserInteractionEnabled = true
    }
}
