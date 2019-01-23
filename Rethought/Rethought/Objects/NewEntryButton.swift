//
//  NewEntryButton.swift
//  rethought
//
//  Created by Dev on 1/23/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class newEntryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public var entryType: Entry.EntryType = .text
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

