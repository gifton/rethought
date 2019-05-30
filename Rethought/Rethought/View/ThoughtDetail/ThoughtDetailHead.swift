//
//  ThoughtDetailHead.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailHead: AnimatableView {
    init(startFrame: CGRect, endFrame: CGRect) {
        super.init(frame: startFrame)
        self.startFrame = startFrame
        self.endFrame = endFrame
        
        backgroundColor = .red
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


