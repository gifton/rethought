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

class HomeViewModel: NSObject {
    init(withmoc moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        self.thoughts = self.fetchThoughts()
        print("thoughtCount: \(thoughts.count)")
        thoughts.forEach { print("thought info for: \($0.id) => \($0.entryCount)") }
        print("entrycount: \(entries.count)")
    }
    
    private var moc: NSManagedObjectContext
    public var entries = [Entry]()
    public var thoughtCount: Int {
        get { return self.thoughts.count }
    }
    public var thoughts = [Thought]() {
        didSet {
            print("thoughts set")
            for thought in thoughts {print(thought.allEntries)}
            var ent = [Entry]()
            thoughts.forEach { ent.append(contentsOf: $0.allEntries) }
            entries = ent
        }
    }
}

extension HomeViewModel {
    func fetchThoughts() -> [Thought] {
        let request = Thought.fetchRequest()
        do {
            let result = try moc.fetch(request)
            guard let castedThoughts: [Thought] = result as? [Thought] else {
                print("unable to cast thoughts from result in fetchrequest")
                return thoughts
            }
            return castedThoughts
        } catch let err {
            print("there was an error fetching: \(err)")
        }
        fatalError("fwk")
    }
}
