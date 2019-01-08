//
//  NewThoughtDelegate.swift
//  rethought
//
//  Created by Dev on 1/4/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//set any UIView to drawer object
//first DrawerPosition is set to DrawerObject.initialState


protocol DrawerControllerDelegate {
    func updateState(_ size: DrawerState)
}


