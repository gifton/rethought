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
    
//    func insertThoughts( _ context: NSManagedObjectContext) {
//        let thoughtFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ThoughtModel")
//        thoughtFetch.fetchLimit = 25
//        thoughtFetch.resultType = .managedObjectResultType
//
//        do {
//            //read data
//            let dataIn = try context.fetch(thoughtFetch) as! [ThoughtModel]
//            for data in dataIn {
//                //create thought
//                let t = Thought(title: data.title!, icon: data.icon!, date: data.date!)
//                //set entrie model
//                guard let entries = data.entryModel!.allObjects as? [EntryModel] else { return }
//                for entry in entries {
//                    //init new entry, id
//                    var  newEntry: Entry?
//                    guard let id = entry.id else { print("couldnt get id"); return }
//                    //depending on entrytype, fill entrys
//
//                    switch entry.type {
//                    case Entry.EntryType.image.rawValue:
//                        //specific gurards
//                        guard let image = entry.image else { print("couldnt get pic"); return }
//                        guard let detail = entry.detail else { print("couldnt get detail"); return }
//                        guard let entryDate = entry.entryDate else { print("couldnt get entryDate"); return }
//                        let img = UIImage(data: image)
//                        //create entry
//                        newEntry = Entry(type: .image, thoughtID: t.ID, detail: detail, date: entryDate, icon: t.icon, image: img ?? UIImage(named: "placeholder.png")!)
//                        newEntry?.id = id
//                    default:
//                        break
//                    }
//                    //if there is a new entry
//                    if newEntry != nil {
//                        t.addNew(entry: newEntry!)
//                    }
//                }
//                //add thoughts to model
//                self.thoughts.append(t)
//            }
//        } catch {
//            fatalError("Failed to fetch employees: \(error)")
//        }
//    }
}
