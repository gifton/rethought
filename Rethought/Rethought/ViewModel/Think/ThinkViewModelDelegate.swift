//
//  ThinkViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


protocol ThinkViewModelDelegate {
    func initiateThought(_ title: String, icon: ThoughtIcon, completion: () -> Void)
}
