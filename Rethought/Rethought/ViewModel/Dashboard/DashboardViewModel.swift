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
    private var thoughts: [Thought] {
        return insertThoughts()
    }
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
//        insertThoughts()
        //after thoughts set, for through to append entries\
        
        print (thoughts.count)
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
    
    func insertThoughts() -> [Thought] {
        let thoughtFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ThoughtModel")
        thoughtFetch.fetchLimit = 25
        thoughtFetch.resultType = .managedObjectResultType
        var out = [Thought]()
        do {
            //read data
            let dataIn = try moc.fetch(thoughtFetch) as! [ThoughtModel]
            for data in dataIn {
                //create thought
                let title = data.title ?? "No title available"
                let icon  = data.icon  ?? "💭"
                let date  = data.date ?? Date()
                let t = Thought(title: title, icon: icon, date: date)
                //set entrie model
                guard let entries = data.entryModel!.allObjects as? [EntryModel] else { print("print returnning from entries"); return out }
                for entry in entries {
                    //init new entry, id
                    var  newEntry: Entry?
                    guard let id = entry.id else { print("couldnt get id"); return out }
                    //depending on entrytype, fill entrys

                    switch entry.type {
                    case Entry.EntryType.image.rawValue:
                        //specific gurards
                        guard let image = entry.image else { print("couldnt get pic"); return out }
                        guard let detail = entry.detail else { print("couldnt get detail"); return out }
                        guard let entryDate = entry.entryDate else { print("couldnt get entryDate"); return out }
                        let img = UIImage(data: image)
                        //create entry
                        newEntry = Entry(type: .image, thoughtID: t.ID, detail: detail, date: Date(), icon: t.icon, image: img ?? UIImage(named: "placeholder.png")!)
                        newEntry?.id = id
                    default:
                        break
                    }
                    //if there is a new entry
                    if newEntry != nil {
                        t.addNew(entry: newEntry!)
                    }
                }
                //add thoughts to model
                out.append(t)
            }
        } catch {
            fatalError("Failed to fetch thoughts: \(error)")
        }
        
        return out
        
    }
    
    func sendThoughtToDB(_ newThought: Thought) -> Bool {
        let thought = ThoughtModel(context: moc)
        
        thought.date = Date()
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
