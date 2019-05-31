
import Foundation
import UIKit

class AnimatableLabel: UILabel, Animatable {
    var startFrame: CGRect?
    var endFrame: CGRect?
    var startColor: UIColor?
    var endColor: UIColor?
    public func update(toAnimationProgress progress: CGFloat) {
        
        // if frames have been set, animate
        if let start = startFrame, let end = endFrame {
            frame = start.animate(toRect: end, forProgress: progress)
        }
        
        // if colors have been set, animate
        if let startColor = startColor, let endColor = endColor {
            textColor = startColor.animate(toColor: endColor, withProgress: progress)
        }
    }
}
