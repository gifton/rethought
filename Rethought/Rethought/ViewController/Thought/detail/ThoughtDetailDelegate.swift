//
//  ThoughtDetailDelegate.swift
//  rethought
//
//  Created by Dev on 12/27/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DetailThoughtDelegate {
    var thought: Thought { get set }
    func returnHome()
    func userTapped(on entryID: String)
}
