
import UIKit

protocol Animatable: AnyObject {
    func update(toAnimationProgress progress: CGFloat)
}

class ViewAnimator {
    private var animatableViews: NSHashTable<AnyObject> = NSHashTable<AnyObject>.weakObjects()
    
    private var currentProgress: CGFloat = 0.0
    
    func register(animatableView view: Animatable) {
        view.update(toAnimationProgress: currentProgress)
        animatableViews.add(view)
    }
    
    func updateAnimation(toProgress progress: CGFloat) {
        currentProgress = progress
        animatableViews.allObjects.forEach { (view) in
            if let view = view as? Animatable {
                view.update(toAnimationProgress: progress)
            }
        }
    }
}
