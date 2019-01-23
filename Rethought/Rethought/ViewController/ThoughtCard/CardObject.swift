//
//  CardView.swift
//  rethought
//
//  Created by Dev on 1/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class CardObject: UIView {
    convenience init(view: UIView, availableIn states: [ThoughtCardState]) {
        self.init(frame: view.frame)
        self.view = view
        self.drawerPositions = states
        self.initialState = states.first!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var drawerPositions: [ThoughtCardState] = [.collapsed]
    var view: UIView!
    var initialState: ThoughtCardState = .collapsed
    
    public var isComplete: Bool?
}
