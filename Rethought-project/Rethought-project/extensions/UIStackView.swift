import Foundation
import UIKit

public extension UIStackView {
    public convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis,
                            spacing: CGFloat = 0.0,
                            alignment: UIStackView.Alignment = .fill,
                            distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
