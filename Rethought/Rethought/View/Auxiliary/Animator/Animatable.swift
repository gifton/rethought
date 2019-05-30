
import UIKit

// views that have animateable children
protocol Animatable: AnyObject {
    func update(toAnimationProgress progress: CGFloat)
}

// pre-made animatable views
class AnimatableLabel: UILabel, Animatable {
    var startFrame: CGRect?
    var endFrame: CGRect?
    var startColor: UIColor?
    var endColor: UIColor?
    public func update(toAnimationProgress progress: CGFloat) {
        if let start = startFrame, let end = endFrame {
            frame = start.animateTo(end, forProgress: progress)
        }
        
        if let startColor = startColor, let endColor = endColor {
            textColor = animatedColors(color1: startColor, color2: endColor, withProgress: progress)
        }
    }
    
    private func animatedColors(color1: UIColor, color2: UIColor, withProgress progress: CGFloat) -> UIColor {
        return UIColor(red: color1.rgba.red + (color2.rgba.red - color1.rgba.red) * progress,
                green: color1.rgba.green + (color2.rgba.green - color1.rgba.green) * progress,
                blue: color1.rgba.blue + (color2.rgba.blue - color1.rgba.blue) * progress,
                alpha: color1.rgba.alpha + (color2.rgba.alpha - color1.rgba.alpha) * progress)
    }
}

class AnimatableView: UIView, Animatable {
    var startFrame: CGRect?
    var endFrame: CGRect?
    var startHeight: CGFloat?
    var endHeight: CGFloat?
    
    func update(toAnimationProgress progress: CGFloat) {
        if let start = startFrame, let end = endFrame {
            frame = start.animateTo(end, forProgress: progress)
        }
        
        if let startHeight = startHeight, let endHeight = endHeight {
            frame.size.height = ((startHeight - endHeight) * progress)
        }
    }
}
