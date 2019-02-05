//
//  ThoughtDetailViewModel.swift
//  rethought
//
//  Created by Dev on 1/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ThoughtDetailViewModel {
    required init(thought: Thought, context: NSManagedObjectContext) {
        self.thought = thought
        self.context = context
    }
    
    var context: NSManagedObjectContext!
    var thought: Thought!
    var entries: [Entry] {
        return self.thought.entries
    }
}


extension ThoughtDetailViewModel: ThoughtDetailViewModelDelegate {
    func getEntries() -> [Entry] {
        return self.entries
    }
    
    func save(entry: Entry) -> Bool {
        self.thought.addNew(entry: entry)
        return true
    }
    
    func update(entry: Entry) -> Bool {
        
        return true
    }
    
    func update(thought: Thought) -> Bool {
        
        return true
    }
    
    func delete(entry: Entry) -> Bool {
        
        return true
    }
    
    func delete(thought: Thought) -> Bool {
        
        return true
    }
    
    
}
