//
//  UIView.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DrawerChildView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, drawerDesignation: DrawerPosition) {
        self.init(frame: frame)
        drawerPosition = drawerDesignation
    }
    
    public var drawerPosition: DrawerPosition?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
