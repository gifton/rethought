//
//  ThoughtDetailViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 1/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ThoughtDetailViewModelDelegate {
    init(thought: Thought, context: NSManagedObjectContext)
    func getEntries() -> [Entry]
    func save(entry: Entry) -> Bool
    func update(entry: Entry) -> Bool
    func update(thought: Thought) -> Bool
    func delete(entry: Entry) -> Bool
    func delete(thought: Thought) -> Bool
}
