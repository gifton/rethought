//
//  CGPoint.swift
//  Rethought
//
//  Created by Dev on 5/31/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func animateTo(_ point: CGPoint, forProgress progress: CGFloat) -> CGPoint {
        return CGPoint(x: x + (point.x - x) * progress,
                       y: y + (point.y - y) * progress)
    }
    
    func animate( toPoint point: CGPoint, forProgress progress: CGFloat) -> CGPoint {
        return CGPoint(x: x + (point.x - x) * progress,
                       y: y + (point.y - y) * progress)
    }
}
