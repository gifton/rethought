//
//  ThoughtDetailView.swift
//  Rethought
//
//  Created by Dev on 5/29/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDetailView: UIView {
    init(model: ThoughtDetailViewModel) {
        self.model = model
        super.init(frame: .zero)
        backgroundColor = .blue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var model: ThoughtDetailViewModel
}
