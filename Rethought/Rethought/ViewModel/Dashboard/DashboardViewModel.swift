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
        for thought in self.thoughts {
            let t = DashboardThought(thought: thought)
            thoughts.append(t)
        }
        return thoughts
    }
    
    //connect core data
    public var moc: NSManagedObjectContext
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
    func retrieve(thought thoughtID: String) -> Thought {
        return thoughts.filter{ $0.ID == thoughtID }.first ?? Thought.init()
    }
    
    //find entry by ID
    func retrieve(entry entryID: String) -> Entry {
        return entries.filter{ $0.id == entryID }.first ?? Entry.init(title: "Not available")
    }
    
    func saveNewThought(_ thought: Thought) -> Bool {
        let out = self.sendThoughtToDB(thought)
        if out {
            self.thoughts.append(thought)
        }
        return out
    }
    
    func fetchThoughts() -> [Thought] {
        print("fetch requested....")
        let fetcher: NSFetchRequest = ThoughtModel.fetchRequest()
        var out = [Thought]()
        do {
            print("begining fetch...")
            let fetchResult = try moc.fetch(fetcher)
            for tm in fetchResult {
                let t = Thought(thoughtModel: tm)
                out.append(t)
            }
        } catch let err {
            print("error!------>")
            print (err)
        }
        print("-------------------------")
        return out
    }
    
    func sendThoughtToDB(_ newThought: Thought) -> Bool {
        let t = ThoughtModel(context: moc)
        t.setModel(thought: newThought)
        
        for ent in newThought.entries {
            let e = EntryModel(context: moc)
            e.setModel(entry: ent, thought: t)
            print("entryModel: \n \(e)")
        }

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
