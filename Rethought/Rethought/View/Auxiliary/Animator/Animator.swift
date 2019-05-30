//
//  Animator.swift
//  Rethought
//
//  Created by Dev on 5/29/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

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

// controllers that have animatable views
protocol Animator {
    func didUpdate()
    func show(optionsFor entry: Entry)
    func register(_ view: Animatable)
}
