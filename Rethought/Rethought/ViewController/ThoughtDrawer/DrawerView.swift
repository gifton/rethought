//
//  Drawer.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DrawerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var position: DrawerPosition = .collapsed
    var state: DrawerState = .closed
    
    var collapsedViews: [UIView] = []
    var miniViews: [UIView] = []
    var mediumViews: [UIView] = []
    var openViews: [UIView] = []
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
}

protocol DrawerDelegate {
    
}
