//
//  String.swift
//  Rethought-project
//
//  Created by Dev on 3/26/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //calculate height of text word wrapped to device width
    func heightFor(font: UIFont, width: CGFloat) -> CGFloat{
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.height
    }
}
