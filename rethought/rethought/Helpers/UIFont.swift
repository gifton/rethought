//
//  UIFont.swift
//  rethought
//
//  Created by Dev on 12/20/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func reTitle(ofSize fontSize: CGFloat) -> UIFont {
        return .systemFont(ofSize: fontSize, weight: .bold)
    }
    static func reBody(ofSize fontSize: CGFloat) -> UIFont {
        return .systemFont(ofSize: fontSize, weight: .regular)
    }
    static func reBodyLight(ofSize fontSize: CGFloat) -> UIFont {
        return .systemFont(ofSize: fontSize, weight: .light)
    }
    
}

enum RethoughtFonts {   
    case body
    case bodyLight
    case title
}
