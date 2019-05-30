//
//  CGRect.swift
//  Rethought
//
//  Created by Dev on 5/29/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func animateTo(_ endRect: CGRect, forProgress progress: CGFloat) -> CGRect {
        if endRect.width == width {
            return CGRect(origin: origin.animateTo(endRect.origin, forProgress: progress),
                          size: size)
        }
        return CGRect(origin: origin.animateTo(endRect.origin, forProgress: progress),
                      size: size.animateTo(endRect.size, forProgress: progress))
    }
}

extension CGPoint {
    func animateTo(_ point: CGPoint, forProgress progress: CGFloat) -> CGPoint {
        return CGPoint(x: x + (point.x - x) * progress,
                       y: y + (point.y - y) * progress)
    }
}

extension CGSize {
    func animateTo(_ size: CGSize, forProgress progress: CGFloat) -> CGSize {
        return CGSize(width: width + (size.width - width) * progress,
                      height: height + (size.height - width) * progress)
    }
}
