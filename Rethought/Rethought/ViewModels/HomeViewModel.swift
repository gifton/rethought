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
        thoughts = fetchThoughts()
        print("thoughtCount: \(thoughts.count)")
        print("entrycount: \(entries.count)")
    }
    
    private var moc: NSManagedObjectContext
    public var thoughts = [Thought]()
    public var entries: [Entry] {
        var ent = [Entry]()
        for t in thoughts {
            ent.append(contentsOf: t.allEntries)
        }
        
        return ent
    }
    public var count: Int {
        get {
            return self.thoughts.count
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
