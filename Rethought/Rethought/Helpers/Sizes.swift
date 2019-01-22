//
//  ViewSize.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct ViewSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ViewSize.SCREEN_WIDTH, ViewSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ViewSize.SCREEN_WIDTH, ViewSize.SCREEN_HEIGHT)
    static let SCALE = UIScreen.main.scale
    static let FRAME = UIScreen.main.bounds
    
    static let thoughtCellSmall = CGSize(width: 100, height: 50)
    let largeCell = CGRect(origin: CGPoint(x: 12.5, y: 10), size: CGSize(width: (UIScreen.main.bounds.width - 25), height: 156))
    static let thoughtTileSize = CGSize(width: (UIScreen.main.bounds.width - 7.5) / 2, height: (UIScreen.main.bounds.width - 7.5) / 2)
}

enum fontSize: CGFloat {
    case xSmall = 10.0
    case small = 12.0
    case medium = 14.0
    case large = 16.0
    case xLarge = 18.0
    case xXLarge = 20.0
    case xXXLarge = 26.0
    case xXXXLarge = 32.0
}
