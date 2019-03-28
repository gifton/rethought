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
    init(with moc: NSManagedObjectContext, type: EntryType) {
        self.moc = moc
        entryType = type
        dataManager.entryType = entryType
        super.init()
        fetchEntries()
        print("of type: \(entryType)")
    }
    
    public var entryType: EntryType
    
    public var entries: [Entry] {
        return dataManager.data
    }
    
    public var count: Int {
        return dataManager.count
    }
    public var locationCount: Int { return 8 }
    
    private var moc: NSManagedObjectContext
    private let dataManager = EntryDataManager()
    
    func search(with keyword: String, completion: () -> Void) {
        let predicate = NSPredicate(format: "title contains[c] '\(keyword)'")
        let predicate2 = NSPredicate(format: "detail contains[c] '\(keyword)'")
        
        switch entryType {
        case .text:
            dataManager.setSearchedEntries(searchForTextEntries(with: predicate), ofType: .link)
            dataManager.setSearchedEntries(searchForTextEntries(with: predicate2), ofType: .link)
        case .link:
            dataManager.setSearchedEntries(searchForLinkEntries(with: predicate), ofType: .link)
        case .media:
            dataManager.setSearchedEntries(searchForMediaEntries(with: predicate2), ofType: .link)
        default:
            dataManager.setSearchedEntries(searchForAllEntries(with: predicate), ofType: .link)
        }
        completion()
    }
}


//all searching funcs for EntryTypes
extension EntryListViewModel {
    //text entries
    private func searchForTextEntries(with predicate: NSPredicate) -> [TextEntryPreview] {
        let fr = TextEntry.sortedFetchRequest(with: predicate)
        var ents = [TextEntryPreview]()
        
        do {
            let output = try moc.fetch(fr)
            ents = output.toPreview()
            dataManager.setSearchedEntries(ents, ofType: .text)
        } catch {
            print("unable to search with given criteria")
        }
        return ents
    }
    
    //link entries
    private func searchForLinkEntries(with predicate: NSPredicate) -> [LinkEntryPreview] {
        let fr = LinkEntry.sortedFetchRequest(with: predicate)
        var ents = [LinkEntryPreview]()
        
        do {
            let output = try moc.fetch(fr)
            ents = output.toPreview()
            dataManager.setSearchedEntries(ents, ofType: .link)
        } catch {
            print("unable to search with given criteria")
        }
        return ents
    }
    
    //text media
    private func searchForMediaEntries(with predicate: NSPredicate) -> [MediaEntryPreview] {
        let fr = MediaEntry.sortedFetchRequest(with: predicate)
        var ents = [MediaEntryPreview]()
        
        do {
            let output = try moc.fetch(fr)
            ents = output.toPreview()
            dataManager.setSearchedEntries(ents, ofType: .media)
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
    
    private func fetchEntries() {
        switch entryType {
        case .text:
            fetchTextEntries()
        case .link:
            fetchLinkEntries()
        case .media:
            fetchMediaEntries()
        default:
            fetchTextEntries()
            fetchLinkEntries()
            fetchMediaEntries()
        }
    }
    
    private func fetchTextEntries() {
        let request = TextEntry.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try moc.fetch(request)
            dataManager.textEntries = result.toPreview()
            print("text entries found... \(result.count)")
        } catch let err {
            print("there was an error fetching: \(err)")
        }
    }
    
    private func fetchMediaEntries() {
        let request = MediaEntry.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try moc.fetch(request)
            dataManager.mediaEntries = result.toPreview()
            print("media entries found... \(result.count)")
        } catch let err {
            print("there was an error fetching: \(err)")
        }
    }
    
    private func fetchLinkEntries() {
        let request = LinkEntry.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try moc.fetch(request)
            dataManager.linkEntries = result.toPreview()
            print("link entries found... \(result.count)")
        } catch let err {
            print("there was an error fetching: \(err)")
        }
    }
    
    private func fetchRecordingEntries() {
        let request = RecordingEntry.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try moc.fetch(request)
            
            print("recording entries found... \(result.count)")
        } catch let err {
            print("there was an error fetching: \(err)")
        }
    }
}

extension EntryListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of entries: \(dataManager.count)")
        return dataManager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dataManager.retrieveCell(with: indexPath, tableView: tableView) else {
            fatalError()
        }
        return cell
    }
    
}

extension EntryListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = dataManager.cellHeightFor(indexPath: indexPath) else { return 100 }
        return height + 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        show(thoughtID: "dfkbvdfv")
        print("HI")
    }
}
