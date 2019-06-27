
import Foundation
import UIKit

extension CGSize {
    func animateTo(_ size: CGSize, forProgress progress: CGFloat) -> CGSize {
        return CGSize(width: width + (size.width - width) * progress,
                      height: height + (size.height - width) * progress)
    }
    func animate( toSize size: CGSize, forProgress progress: CGFloat) -> CGSize {
        return CGSize(width: width + (size.width - width) * progress,
                      height: height + (size.height - width) * progress)
    }
    
    //multiplier
    func multiplier(_ multiplier: CGFloat) -> CGSize {
        return CGSize(width: self.width * multiplier, height: self.height * multiplier)
    }
}
