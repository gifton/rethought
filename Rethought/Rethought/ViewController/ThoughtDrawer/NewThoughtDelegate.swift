//
//  NewThoughtDelegate.swift
//  rethought
//
//  Created by Dev on 1/4/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol NewThoughtDelegate {
    func save(_ thought: Thought)
    var thoughtState: thoughtDrawerHeight { get set }
}

enum thoughtDrawerHeight: CGFloat {
    case closed = 103.0
    case beginThought = 156
    case completeThought = 331
    case isWriting = 423
}

extension ViewSize {
    static let drawerClosed = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 103, width: ViewSize.SCREEN_WIDTH, height: 103)
    static let drawerBeginThought = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 156, width: ViewSize.SCREEN_WIDTH, height: 156)
    static let drawerCompleteThought = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 331, width: ViewSize.SCREEN_WIDTH, height: 331)
    static let drawerIsWriting = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 560, width: ViewSize.SCREEN_WIDTH, height: 560)
}
