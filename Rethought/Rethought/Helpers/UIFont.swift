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
        return UIFont(name: "Lato-Bold ", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .heavy)
    }
    static func reBody(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular ", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .regular)
    }
    static func reBodyLight(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Light ", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: .light)
    }
    
}

enum RethoughtFonts {   
    case body
    case bodyLight
    case title
}
