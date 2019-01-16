//
//  ThoughtCardController.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtCardController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public var card: ThoughtCard?
    private var delegate: DashboardDelegate?
    
    func setCard(delegate: DashboardDelegate) {
        self.delegate = delegate
        card = ThoughtCard(frame: .zero, delegate: self)
    }
}

extension ThoughtCardController: ThoughtCardDelegate {
    func updateState(state: ThoughtCardState) {
        delegate?.changeSize(size: state)
    }
    
    
}
