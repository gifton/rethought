import Foundation
import UIKit

extension CGRect {
    func animateTo(_ endRect: CGRect, forProgress progress: CGFloat) -> CGRect {
        if endRect.width == width {
            return CGRect(origin: origin.animateTo(endRect.origin, forProgress: progress),
                          size: size)
        }
        return CGRect(origin: origin.animate(toPoint: endRect.origin, forProgress: progress),
                      size: size.animateTo(endRect.size, forProgress: progress))
    }
    
    func animate(toRect rect: CGRect, forProgress progress: CGFloat) -> CGRect {
        if rect.width == width {
            return CGRect(origin: origin.animate(toPoint: rect.origin, forProgress: progress),
                          size: size)
        }
        return CGRect(origin: origin.animate(toPoint: rect.origin, forProgress: progress),
                      size: size.animateTo(rect.size, forProgress: progress))
    }
}
