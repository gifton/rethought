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
        return UIFont(name: "SanFranciscoDisplay-Bold ", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .medium)
    }
    static func reBody(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "SanFranciscoText-Regular ", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .regular)
    }
    static func reBodyLight(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "SanFranciscoText-Light ", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .light)
    }
}

enum RethoughtFonts {   
    case body
    case bodyLight
    case title
}
