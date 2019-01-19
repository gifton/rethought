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
    func startNewEntry(_ type: Entry.EntryType)
    func addEntry(_ entry: Entry)
    func addThoughtComponents(title: String, icon: ThoughtIcon)
    func didPressSave() 
}


enum ThoughtCardState {
    case collapsed
    case cardIsEditing
    case cardIsDoneEditing
}

func cardHeight(_ state: ThoughtCardState) -> CGFloat {
    switch state {
    case .collapsed:
        return 69
    default:
        return 367
    }
}
