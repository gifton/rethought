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
        return self.sendThoughtToDB(thought)
    }
    
    func fetchThoughts() -> [Thought] {
        let fetcher: NSFetchRequest = ThoughtModel.fetchRequest()
        var out = [Thought]()
        do {
            let fetchResult = try moc.fetch(fetcher)
            for tm in fetchResult {
                let t = Thought(thoughtModel: tm)
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
        let thought = ThoughtModel(context: moc)
        
        thought.date = newThought.createdAt
        thought.icon = newThought.icon
        thought.id = newThought.ID
        thought.title = newThought.title
        
        for entry in newThought.entries {
            let entryOut = EntryModel(context: moc)
            guard let imageData = entry.image?.pngData() else { continue }
            guard let linkImageData = entry.linkImage?.pngData() else { continue }
            entryOut.date = entry.date
            entryOut.detail = entry.detail
            entryOut.image = imageData
            entryOut.entryID = thought.id
            entryOut.entryTitle = entry.title
            entryOut.link = entry.link
            entryOut.linkImage = linkImageData
            entryOut.linkTitle = entry.linkTitle
            thought.addToEntryModel(entryOut)
        }
        do {
            try moc.save()
            return true
        } catch let err  {
            print("----------error-----------")
            print(err)
            return false
        }
    }
}
