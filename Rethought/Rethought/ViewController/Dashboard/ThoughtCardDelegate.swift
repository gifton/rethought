//
//  ThoughtCardDelegate.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol ThoughtCardDelegate {
    func updateState(state: ThoughtCardState)
}


enum ThoughtCardState {
    case collapsed
    case cardIsEditing
    case crdIsDoneEditing
}

func cardHeight(_ state: ThoughtCardState) -> CGFloat {
    switch state {
    case .collapsed:
        return 69
    default:
        return 367
    }
}
