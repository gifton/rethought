//
//  DrawerSources.swift
//  rethought
//
//  Created by Dev on 1/7/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DrawerDelegate {
    func change(position to: DrawerPosition)
    func change(state to: DrawerState)
}

enum DrawerPosition: CGFloat {
    case collapsed = 103.0
    case mini = 156
    case medium = 331
    case open = 423
}

enum DrawerState {
    case closed
    case beginThought
    case addTitle
    case addEmoji
    case continueTheThought
}

protocol DrawerObjectSource {
    var closedChildren: [DrawerChild] { get }
//    var beginThoughtCildren: [DrawerChild] { get set }
//    var titleChildren:[DrawerChild] { get set }
//    var emojiChildren: [DrawerChild] { get set }
//    var continueTheThoughtChildren: [DrawerChild] { get set }
}
