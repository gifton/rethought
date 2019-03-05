//
//  String.swift
//  rethought
//
//  Created by Dev on 1/4/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//thought icon only allows 1 char at a time
final class ThoughtIcon {
    public var icon: String
    init(_ icon: String?) {
        if icon == nil {
            self.icon = "🚫"
        } else {
            //if theres multiple characters default to "🚫"
            if icon!.count != 1 {
                self.icon = "🚫"
            } else {
                self.icon = icon!
            }
        }
    }
}
