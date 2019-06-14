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
    func displayDetail(forThought thought: Thought) -> ThoughtDetailViewModel
    func didSelectEntry(ofType type: EntryType, completion: () -> ())
}

enum FilterDirection {
    case ascending
    case descending
    
    func getString(_ input: FilterDirection) -> String {
        switch input {
        case .ascending: return "from oldest to newest"
        case .descending: return "from newest to  oldest"
        }
    }
}
