
import UIKit

// views that have animateable children
protocol Animatable: AnyObject {
    func update(toAnimationProgress progress: CGFloat)
}


