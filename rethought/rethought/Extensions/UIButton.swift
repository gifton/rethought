//
//  UIView.swift
//  rethought
//
//  Created by Dev on 1/6/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//add atrtibuted text  to UIButton

extension UIButton {
    func addAttText(color: UIColor, size: CGFloat, font: RethoughtFonts, string: String) {
        var output = NSAttributedString()
        switch font {
        case .body:
            let att = [ NSAttributedString.Key.font: UIFont.reBody(ofSize: size),  NSAttributedString.Key.foregroundColor: color]
            output = NSAttributedString(string: string, attributes: att as [NSAttributedString.Key : Any])
        case .title:
            let att = [ NSAttributedString.Key.font: UIFont.reTitle(ofSize: size),  NSAttributedString.Key.foregroundColor: color]
            output = NSAttributedString(string: string, attributes: att as [NSAttributedString.Key : Any])
        default:
            let att = [ NSAttributedString.Key.font: UIFont.reBodyLight(ofSize: size),  NSAttributedString.Key.foregroundColor: color]
            output = NSAttributedString(string: string, attributes: att as [NSAttributedString.Key : Any])
        }
        self.setAttributedTitle(nil, for: .normal)
        self.setAttributedTitle(output, for: .normal)
    }
}
