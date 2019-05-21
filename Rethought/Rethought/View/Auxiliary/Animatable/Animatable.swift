
import UIKit

// views that have animateable children
protocol Animatable: AnyObject {
    func update(toAnimationProgress progress: CGFloat)
}

// controllers that have animatable views
protocol Animator {
    func didUpdate()
    func show(optionsFor entry: Entry)
}
