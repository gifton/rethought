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
    
    func requestDeletion(forthought thought: Thought)
    func refresh()
    func retrieve(thought id: String) -> Thought?
    func retrieve(entry id: String) -> Entry?
    func displayDetail(forThought thought: Thought) -> ThoughtDetailViewModel
}
