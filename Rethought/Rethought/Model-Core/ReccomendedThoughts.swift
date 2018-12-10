//
//  ThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct ReccomendedThoughtCell {
    let cellType: ScrollViewCellType
    let icons: [String]
    let lastEntryDate: [String]
    
    init(_ cellType: ScrollViewCellType, thoughts: [Thought]) {
        self.cellType = cellType
        for thought in thoughts {
            lastEntryDate.append(thought.lastEdited)
        }
    }
}
