//
//  UIView.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//class wrapper for drawer since DrawerView would be MASSIVE otherwise

class DrawerChild: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, state: DrawerState?) {
        self.init(frame: frame)
        
        guard let s = state else { return }
        self.state = s
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var state: DrawerState = .closed
    
    func nextPosition(from: DrawerPosition) {
        
    }

}
