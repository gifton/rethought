//
//  NewThoughtDelegate.swift
//  rethought
//
//  Created by Dev on 1/4/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation

protocol NewThoughtDelegate {
    func save(_ thought: Thought)
    var thoughtState: NewThoughtView.NewThoughtViewState { get set }
}
