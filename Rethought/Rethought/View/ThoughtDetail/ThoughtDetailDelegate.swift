//
//  ThoughtDetailDelegate.swift
//  Rethought
//
//  Created by Dev on 5/30/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation

protocol ThoughtDetailDelegate {
    func displayEntryType(_ type: EntryType) -> Bool
    func saveEntryWith(builder: EntryBuilder) -> Bool
    func requestClose()
    func delete(entry: Entry)
    func delete(thought: Thought)
    func search(for payload: String)
    func endSearch()
    func updateIcon(to: String)
    var thought: ThoughtPreview { get }
    
}
