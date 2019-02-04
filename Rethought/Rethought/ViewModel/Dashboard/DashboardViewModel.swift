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
        for thought in self.thoughts {
            let dThought = DashboardThought(thought: thought)
            thoughts.append(dThought)
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
        printThoughts()
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
        print("dashboardViewModel recieved thought:")
        print(thought)
        return self.sendThoughtToDB(thought)
    }
    
    func printThoughts() {
        let fetcher: NSFetchRequest = ThoughtModel.fetchRequest()
        do {
            let results = try moc.fetch(fetcher)
            for i in results {
                print (i.title)
            }
        } catch let err {
            print (err)
        }
    }
    
    func fetchThoughts() -> [Thought] {
        print("fetching thoughts....")
        let fetcher: NSFetchRequest = ThoughtModel.fetchRequest()
        var out = [Thought]()
        do {
            let fetchResult = try moc.fetch(fetcher)
            for tm in fetchResult {
                print("thoughtModel recieved from DB: \n \(tm)")
                let t = Thought(thoughtModel: tm)
                print("thought converted from TM: \n \(t)")
                out.append(t)
            }
        } catch let err {
            print (err)
        }
        print("-------------------------")
        print (out.count)
        return out
    }
    
    func sendThoughtToDB(_ newThought: Thought) -> Bool {
        let thought = ThoughtModel(thought: newThought, moc: moc)
        
        for entry in newThought.entries {
            let entOut = EntryModel(moc: moc, entry: entry)
            thought.addToEntryModels(entOut)
        }
        
        print("thought prepared for DB insertion, thoughtModel: \n \(thought)")
        
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
