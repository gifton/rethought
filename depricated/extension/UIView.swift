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
        self.layer.insertSublayer(gradient, at: 1)
    }
    func addGradient(){
        
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.frame.size
        gradient.colors = [UIColor(hex: "F9FCFF").cgColor,UIColor(hex: "DEE0F3").cgColor] //Or any colors
        self.layer.addSublayer(gradient)
        
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

extension UIView {
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        layer.cornerRadius = CGFloat(frame.width / 20)
        

        
        layer.colors = [UIColor(hex: "F9FCFF").cgColor,UIColor(hex: "DEE0F3").cgColor]
        self.layer.insertSublayer(layer, at: 0)
    }
}


extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func animateTemporaryView(duration: Double, view: UIView) {
        UIView.animate(withDuration: duration, animations: {
            view.layer.opacity = 1.0
        }) { (false) in
            UIView.animate(withDuration: 1.0, animations: {
                view.layer.opacity = 0.0
            })
        }
    }
    
    func buttonPressAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.layer.opacity = 0.75
        }) { (true) in
            self.layer.opacity = 1.0
        }
    }
    
}
