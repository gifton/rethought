//
//  HomeViewModelDelegate.swift
//  Rethought
//
//  Created by Dev on 5/18/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: NSObject {
    var entries: [Entry] { get }
    func refresh()
    func requestDeletion(forthought thought: Thought)
    func retrieve(thought id: String) -> Thought?
    func retrieve(entry row: Int) -> EntryDetailViewModel
    func retrieveModelFor(row: Int) -> ThoughtDetailViewModel
    func didSelectEntry(ofType type: EntryType, completion: () -> ())
    func delete(_ Thought: Thought)
    func delete(_ entry: Entry)
}
