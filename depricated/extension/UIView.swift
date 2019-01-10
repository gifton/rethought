//
//  UIView.swift
//  rethought
//
//  Created by Dev on 1/8/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func giveLightBackground(radius: CGFloat = 5.0) {
        backgroundColor = UIColor.white.withAlphaComponent(0.4)
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    func giveDarkBackground(radius: CGFloat = 5.0) {
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    func applyGradient(color1: UIColor, color2: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]  
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.masksToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
    }
    func addAttributedText(color: UIColor = .black, size: fontSize.RawValue, font: RethoughtFonts, string: String) -> NSAttributedString {
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
        return output
    }
}
