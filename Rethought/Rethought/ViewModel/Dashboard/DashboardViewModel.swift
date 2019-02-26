//
//  HomeViewModel.swift
//  rethought
//
//  Created by Dev on 01/15/19.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//Dashboard VM
class DashboardViewModel: DashboardViewModelDelegate {
    
    //return list of ALL thoughts
    func getThoughts() -> [DashboardThought] {
        var thoughts = [DashboardThought]()
        print("COUNT: \(self.thoughts.count)")
        print("====")
        for thought in self.thoughts {
            let t = DashboardThought(icon: thought.icon.icon, createdAt: thought.date, thoughtID: thought.id, entryCount: thought.entryCount, title: thought.title)
            thoughts.append(t)
        }
        return thoughts
    }
    
    //connect core data
    public var moc: NSManagedObjectContext!
    private var thoughts = [Thought]()
    
    private var entries: [Entry] {
        var ents = [Entry]()
        for thought in self.thoughts {
            for entry in thought.entries{ ents.append(entry) }
        }
        
        return ents
    }
    public var count: Int {
        get {
            return self.thoughts.count
        }
    }
    
    //set moc at initialization
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        print("initialzed moc!")
        print(moc)
        //set thoughts
        self.thoughts = fetchThoughts()
    }
}

extension DashboardViewModel {
    
    //return most recent entries accross all thoughts
    func getRecentEntries() -> [ReccomendedThought] {
        var recentEntries = [ReccomendedThought]()
        for thought in self.thoughts {
            let entryPrev = ReccomendedThought(thought)
            recentEntries.append(entryPrev)
        }
        return recentEntries
    }
    
    //find thought by ID
    func retrieve(thought thoughtID: String) -> Thought? {
        return thoughts.filter{ $0.id == thoughtID }.first ?? nil
    }
    
    //find entry by ID
    func retrieve(entry entryID: String) -> Entry? {
        return entries.filter{ $0.id == entryID }.first ?? nil
    }
    
    func saveNewThought(_ thought: Thought) -> Bool {
        let out = self.sendThoughtToDB(thought)
        if out {
            self.thoughts.append(thought)
        }
        return out
    }
    
    func fetchThoughts() -> [Thought] {
        let request = Thought.fetchRequest()
        do {
            let result = try moc.fetch(request)
            return result as! [Thought]
        } catch let err {
            print("there was an error fetching: \(err)")
        }
        fatalError("fwk")
    }
    
    func sendThoughtToDB(_ newThought: Thought) -> Bool {

        do {
            try moc.save()
            return true
        } catch let err  {
            print("---error---")
            print(err)
            return false
        }
    }
}
