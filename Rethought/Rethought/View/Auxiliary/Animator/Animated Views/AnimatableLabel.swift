
import Foundation
import UIKit

class AnimatableLabel: UILabel, Animatable {
    var startFrame: CGRect?
    var endFrame: CGRect?
    var startColor: UIColor?
    var endColor: UIColor?
    var speed: CGFloat = 1.0
    public func update(toAnimationProgress progress: CGFloat) {
        
        // if frames have been set, animate
        if let start = startFrame, let end = endFrame {
            frame = start.animate(toRect: end, forProgress: progress * speed)
        }
        
        // if colors have been set, animate
        if let startColor = startColor, let endColor = endColor {
            textColor = startColor.animate(toColor: endColor, withProgress: progress * speed)
        }
    }
}
