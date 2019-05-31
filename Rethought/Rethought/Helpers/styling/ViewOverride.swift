//
//  ViewOverride.swift
//  Rethought
//
//  Created by Dev on 5/31/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DrawBar: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setStrokeColor(UIColor.blue.cgColor)
        context?.move(to: CGPoint(x:0, y: 0))
        context?.addLine(to: CGPoint(x: 20, y: 30))
        context?.strokePath()
        
        print("in DrawOnView")
    }
}
