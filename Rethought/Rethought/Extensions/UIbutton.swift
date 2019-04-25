//
//  UIbutton.swift
//  Rethought
//
//  Created by Dev on 4/19/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MessageButton: UIButton {
    public var entryType: MSGContext.type = .none
    public var messageButtonType: MessageButtonType = .entry
}

extension UIButton {
    public func isDisabled() {
        layer.opacity = 0.4
    }
    public func isEnabled() {
        layer.opacity = 1.0
        self.showsTouchWhenHighlighted = true
    }
}
