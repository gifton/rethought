//
//  TextField.swift
//  rethought
//
//  Created by Dev on 1/17/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//add padding to UITextfield
extension UITextField {
    func addLeftPadding(size: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
