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
    func change(state: DrawerState)
    var objectSource: [DrawerObject] { get set }
}

