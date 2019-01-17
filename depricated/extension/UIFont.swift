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
        return UIFont(name: "Lato-Bold", size: fontSize) ?? .boldSystemFont(ofSize: fontSize)
    }
    static func reBody(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato", size: fontSize) ?? .boldSystemFont(ofSize: fontSize)
    }
    static func reBodyLight(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Light", size: fontSize) ?? .boldSystemFont(ofSize: fontSize)
    }
}

enum RethoughtFonts {   
    case body
    case bodyLight
    case title
}
