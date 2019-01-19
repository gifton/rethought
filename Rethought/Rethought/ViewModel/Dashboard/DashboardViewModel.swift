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

class DashboardViewModel: DashboardViewModelDelegate {
    func getRecentEntries() -> EntryPreview {
        return EntryPreview(entry: Entry(title: "FWK"))
    }
    
    func getThoughts() -> [DashboardThought] {
        var thoughts = [DashboardThought]()
        let thoughtFetcher = NSFetchRequest<NSFetchRequestResult>(entityName: "ThoughtModel")
        do {
            if let dataIn = try moc.fetch(thoughtFetcher) as? [ThoughtModel] {
                for data in dataIn {
                    let t = Thought(title: data.title!, icon: data.icon!, date: data.date!)
                    let dt = DashboardThought(thought: t)
                    thoughts.append(dt)
                }
            }
        } catch let err {
            print("error pulling data from db \(err)")
        }
        return thoughts
    }
    
    private var viewDelegate: HomeViewControllerDelegate?
    public var moc: NSManagedObjectContext
    
    private var thoughts: [Thought]
    private var entries: [Entry] = []
    
    init(thoughts: [Thought], moc: NSManagedObjectContext) {
        self.thoughts = thoughts
        for thought in thoughts {
            for entry in thought.entries{ self.entries.append(entry) }
        }
        self.moc = moc
        
        let thoughtFetcher = NSFetchRequest<NSFetchRequestResult>(entityName: "ThoughtModel")
        do {
            if let dataIn = try moc.fetch(thoughtFetcher) as? [ThoughtModel] {
                for data in dataIn {
                    let t = Thought(title: data.title!, icon: data.icon!, date: data.date!)
                    self.thoughts.append(t)
                }
            }
        } catch let err {
            print("error pulling data from db \(err)")
        }
    }
}

extension DashboardViewModel {
    func getRecentEntries() -> [EntryPreview] {
        var recentEntries = [EntryPreview]()
        for (count, entry) in self.entries.enumerated() {
            if count == 25 {
                break
            }
            let entryPrev = EntryPreview(entry: entry)
            recentEntries.append(entryPrev)
        }
        return recentEntries
    }
    func retrieve(thought thoughtID: String) -> Thought {
        return thoughts.filter{ $0.ID == thoughtID }.first ?? Thought.init()
    }
    func retrieve(entry entryID: String) -> Entry {
        return entries.filter{ $0.id == entryID }.first ?? Entry.init(title: "Not available")
    }
    
    func test() {
        let thought = ThoughtModel(context: moc)
        thought.date = Date()
        thought.icon = "🏚"
        thought.id = "dfvbbedf"
        thought.title = "Giftons new title2!"
        
        do {
            try moc.save()
            print("woah it wrked!")
        } catch let err {
            print(err)
        }
        pullTest()
    }
    
    func pullTest() {
        let fetcher = NSFetchRequest<NSFetchRequestResult>(entityName: "ThoughtModel")
        
//        fetcher.execute()
        do {
            let out = try moc.fetch(fetcher)
            for o in out {
                print(o)
            }
        } catch let err {
            print("error pulling data from db \(err)")
        }
       
    }
}
