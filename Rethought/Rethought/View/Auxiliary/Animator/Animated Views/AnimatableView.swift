
import Foundation
import UIKit

class AnimatableView: UIView, Animatable {
    var startFrame: CGRect?
    var endFrame: CGRect?
    var startHeight: CGFloat?
    var endHeight: CGFloat?
    var startAlpha: CGFloat = 1.0
    var endAlpha: CGFloat = 1.0
    var startColor: UIColor?
    var endColor: UIColor?
    var speed: CGFloat = 1.0
    
    func update(toAnimationProgress progress: CGFloat) {
        
        // if frames have been set, animate it
        if let start = startFrame, let end = endFrame {
            frame = start.animate(toRect: end, forProgress: progress * speed)
        }
        
        
        if let startHeight = startHeight, let endHeight = endHeight {
            frame.size.height = ((startHeight - endHeight) * (progress * speed))
        }
        
        // check if alphas have been changed
        // if start alpha is greater, subtract
        if endAlpha > startAlpha { self.alpha = startAlpha + (endAlpha - startAlpha) * (progress * speed) }
        else if endAlpha < startAlpha { self.alpha = startAlpha - (endAlpha + startAlpha) * progress }
        
        if let startColor = startColor, let endColor = endColor {
            backgroundColor = startColor.animate(toColor: endColor, withProgress: progress)
        }
    }
}
