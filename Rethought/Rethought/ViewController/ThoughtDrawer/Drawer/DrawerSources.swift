//
//  DrawerSources.swift
//  rethought
//
//  Created by Dev on 1/7/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DrawerObjectSource {
    var drawerChildren: [DrawerObject] { get }
}
