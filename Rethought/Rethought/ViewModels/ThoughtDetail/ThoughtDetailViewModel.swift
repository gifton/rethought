//
//  ThoughtDetailViewModel.swift
//  Rethought
//
//  Created by Dev on 5/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class ThoughtDetailViewModel: ThoughtDetailViewModelDelegate {
    required init(withThought thought: Thought, _ moc: NSManagedObjectContext) {
        self.moc = moc
        self.thought = thought
    }
    
    private var moc: NSManagedObjectContext
    private var thought: Thought
    public var thoughtPreview: ThoughtPreview { return thought.preview }
    public var entryCount: EntryCount { return thought.entryCount }
    
    func buildEntry<T>(payload: T, withLocation location: CLLocation?) where T : EntryBuilder {
        print("creating entry data model")
        _ = Entry.insertEntry(into: moc,
                              location: location,
                              payload: payload,
                              thought: thought)
        save()
    }
    
    func updateThoughtIcon(toIcon icon: ThoughtIcon) {
        print("updating icon")
    }
    
    func delete(entryWithID id: String) {
        print("deleting entry for thought...")
    }
    
    func deleteThought() {
        print("deleting thought")
    }
    
    func save() {
        do {
            try moc.save()
            let count = thought.entryCount
            print("entry save complete in thoughtDetail, entryCount: \(count)")
        } catch let err {
            print(err)
        }
    }
    
    func search(_ payload: String) {
        print("im searching for something!")
    }
}
