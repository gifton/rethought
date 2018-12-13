//
//  User.swift
//  rethought
//
//  Created by Dev on 12/9/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class User {
    var name: String
    var email: String
    let icon: String
    
    init(_ name: String, _ email: String, _ icon: String) {
        self.name = name
        self.email = email
        self.icon = icon
    }
}
