//
//  ThoughtDetailDelegate.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation

protocol ThoughtDetailDelegate {
    func requestClose()
    func delete(entry: Entry)
    func delete(thought: Thought)
    func search(for payload: String)
    func endSearch()
    func updateIcon(to: String)
    var thought: ThoughtPreview { get }
    
}
