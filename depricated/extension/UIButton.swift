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

class DrawerButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, nextState: DrawerState?) {
        self.init(frame: frame)
        
        guard let nextState = nextState else { return }
        
        self.nextState = nextState
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nextState: DrawerState = .closed

}

extension DrawerView {
    func addChildren(_ children: [UIView]) {
        for child in children {
            addSubview(child)
        }
    }
}
