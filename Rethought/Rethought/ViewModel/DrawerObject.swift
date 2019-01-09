//
//  DrawerObject.swift
//  rethought
//
//  Created by Dev on 1/8/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//all objects put in drawer need to declare what drawer states they are available in
//initial state is set to first state in availableIn states: [DrawerState]
class DrawerObject {
    init(view: UIView, availableIn states: [DrawerState]) {
        self.view = view
        self.drawerPositions = states
        self.initialState = states.first!
    }
    
    var drawerPositions: [DrawerState]
    var view: UIView
    var initialState: DrawerState = .closed
    
    public var isComplete: Bool?
}
