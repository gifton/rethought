//
//  ThoughtCell.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct ReccomendedThoughtCellViewModel {
    var icons: [String] = []
    var lastEntryDate: [String] = []
    var id: [String] = []
    
    init(_ cellType: ScrollViewCellType, thoughts: [Thought]) {
        for thought in thoughts {
            self.id.append(thought.ID)
        }
        
    }
}
