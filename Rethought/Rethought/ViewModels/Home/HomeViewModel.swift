//
//  HomeViewModel.swift
//  Rethought
//
//  Created by Dev on 5/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

// handle all logic for showing the home screen
class HomeViewModel: NSObject {
    init(withmoc moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        setup()
    }
    
    // MARK: private vars
    private var moc: NSManagedObjectContext
    
    // MARK: public vars
    // entry is dependant on thoughts to traverse the relationship
    // less read time to use relationship than make a seperate CD call
    public var entries: [Entry] {
        get { return thoughts.entries() }
    }
    public var thoughtCount: Int {
        get { return self.thoughts.count }
    }
    public var entryCount: Int {
        return entries.count
    }
    public var thoughts: [Thought] = []
    
    private func setup() {
        thoughts = fetchThoughts()
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    
    func requestDeletion(forthought thought: Thought) {
    print("thought deleted!")
    }
    
    func retrieve(thought id: String) -> Thought? {
        return thoughts.filter{ $0.id == id }.first ?? nil
    }
    
    func retrieve(entry id: String) -> Entry? {
        return entries.filter{ $0.id == id }.first ?? nil
    }
    
    func refresh() {
//        thoughts = []
//        thoughts = fetchThoughts()
    }
    
    func fetchThoughts() -> [Thought] {
        let request = Thought.sortedFetchRequest
        do { return try moc.fetch(request) } catch let err {
            print("there was an error fetching: \(err)")
        }
        fatalError("fwk")
    }
}
