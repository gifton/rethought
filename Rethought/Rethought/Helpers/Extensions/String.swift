
import Foundation
import UIKit

extension String {
    //calculate height of text word wrapped to device width
    func sizeFor(font: UIFont, width: CGFloat) -> CGSize{
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.size
    }
}
