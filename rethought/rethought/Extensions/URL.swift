//
//  File.swift
//  rethought
//
//  Created by Dev on 2/23/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    static func imagePlaceHolder() -> URL {
        let url = self.init(string: "https://ws.imgix.net/photos/asea24_kikipolf.jpg?w=1000&dpr=2&auto=compress&q=80&cs=tinysrgb&ixlib=js-1.0.6")
        return url!
    }
}
