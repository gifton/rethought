//
//  EntryListViewModel.swift
//  Rethought-project
//
//  Created by Dev on 3/20/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class EntryListViewModel: NSObject {
    init(with moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        
    }
    
    public var entryType: EntryType {
        get {
            return dataManager.entryType!
        }
        set {
            dataManager.entryType = newValue
        }
    }
    public var entries: [Entry] {
        
        return dataManager.entryData
    }
    
    private var moc: NSManagedObjectContext
    private let dataManager = ModelDataManager()
    
    func search(with keyword: String, completion: () -> Void) {
        let predicate = NSPredicate(format: "title contains[c] '\(keyword)'")
        
        switch entryType {
        case .text:
            dataManager.searchedEntries(searchForTextEntries(with: predicate))
            dataManager.entryType = .text
        case .link:
            dataManager.searchedEntries(searchForLinkEntries(with: predicate))
            dataManager.entryType = .link
        case .all:
            dataManager.searchedEntries(searchForAllEntries(with: predicate))
            dataManager.entryType = .all
        default:
            dataManager.searchedEntries(searchForMediaEntries(with: predicate))
            dataManager.entryType = .media
        }
        completion()
    }
}


//all searching funcs for EntryTypes
extension EntryListViewModel {
    //text entries
    private func searchForTextEntries(with predicate: NSPredicate) -> [Entry] {
        let fr = TextEntry.sortedFetchRequest(with: predicate)
        var ents = [Entry]()
        
        do {
            let output = try moc.fetch(fr)
            output.forEach { (entry) in
                ents.append(TextEntryPreview(entry))
            }
            
        } catch {
            print("unable to search with given criteria")
        }
        return ents
    }
    
    //link entries
    private func searchForLinkEntries(with predicate: NSPredicate) -> [Entry] {
        let fr = LinkEntry.sortedFetchRequest(with: predicate)
        var ents = [Entry]()
        
        do {
            let output = try moc.fetch(fr)
            output.forEach { (entry) in
                ents.append(LinkEntryPreview(entry))
            }
            
        } catch {
            print("unable to search with given criteria")
        }
        return ents
    }
    
    //text media
    private func searchForMediaEntries(with predicate: NSPredicate) -> [Entry] {
        let fr = MediaEntry.sortedFetchRequest(with: predicate)
        var ents = [Entry]()
        
        do {
            let output = try moc.fetch(fr)
            output.forEach { (entry) in
                ents.append(MediaEntryPreview(entry))
            }
            
        } catch {
            print("unable to search with given criteria")
        }
        return ents
    }
    
    private func searchForRecordingEntries(with predicate: NSPredicate) {
        print("searched for recordings...")
    }
    
    private func searchForAllEntries(with predicate: NSPredicate) -> [Entry] {
        var output = [Entry]()
        output.append(contentsOf: searchForTextEntries(with: predicate))
        output.append(contentsOf: searchForLinkEntries(with: predicate))
        output.append(contentsOf: searchForMediaEntries(with: predicate))
        
        return output
    }
    
    func doneWithSearch() {
        dataManager.isSearching = false
    }
}

extension EntryListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: EntryListTextCell.self, for: indexPath)
        guard let currentEntry = dataManager.entryData[indexPath.row] as? TextEntryPreview else { return cell}
        cell.set(with: currentEntry)
        return cell
    }
    
}

extension EntryListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        let current = model.entries[indexPath.row]
        //        switch current.type {
        //        case .text:
        //            guard let ent: TextEntryPreview = current as? TextEntryPreview else { return 100 }
        //            print(ent.height)
        //            return ent.height
        //        case .media:
        //            guard let ent: MediaEntryPreview = current as? MediaEntryPreview else { return 100}
        //            return ent.height
        //        default:
        //            return 120
        //        }
        print("initiated height")
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        show(thoughtID: "dfkbvdfv")
        print("HI")
    }
}
