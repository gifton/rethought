//
//  DrawerComponents.swift
//  rethought
//
//  Created by Dev on 1/8/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

enum DrawerPosition: CGFloat {
    case collapsed = 103.0
    case mini = 156
    case medium = 331
    case open = 480
}

enum DrawerState: CaseIterable {
    case closed
    case beginThought
    case addTitle
    case addEmoji
    case continueTheThought
}

extension ViewSize {
    static let drawerIsCollapsed = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 103, width: ViewSize.SCREEN_WIDTH, height: 103)
    static let drawerIsMini = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 156, width: ViewSize.SCREEN_WIDTH, height: 156)
    static let drawerIsMedium = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 331, width: ViewSize.SCREEN_WIDTH, height: 331)
    static let drawerIsOpen = CGRect(x: 0, y: ViewSize.SCREEN_HEIGHT - 560, width: ViewSize.SCREEN_WIDTH, height: 560)
}

enum thoughtDrawerHeight: CGFloat {
    case closed = 103.0
    case beginThought = 156
    case completeThought = 331
    case isWriting = 480
}

enum ThoughtDrawerWritingType {
    case title
    case icon
}
