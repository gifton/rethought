//
//  DrawerDelegate.swift
//  rethought
//
//  Created by Dev on 1/8/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DrawerDelegate {
    func change(state to: DrawerState)
    var objectSource: [DrawerObject] { get set }
}


class DrawerObject {
    init(view: UIView, availableIn states: [DrawerState]) {
        self.view = view
        self.drawerPositions = states
        self.initialState = states.first!
    }
    var drawerPositions: [DrawerState]
    var view: UIView
    var initialState: DrawerState = .closed
}
