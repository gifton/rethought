//
//  EntryDataManager.swift
//  Rethought-project
//
//  Created by Dev on 3/27/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

// MARK: Entry manager
class EntryDataManager: NSObject {
    override init() {
        super.init()
    }
    
    // MARK: private
    private var entries: [Entry] {
        var out = [Entry]()
        out.append(contentsOf: textEntries)
        out.append(contentsOf: mediaEntries)
        out.append(contentsOf: linkEntries)
        
        out.sort { (ent, entry) -> Bool in
            ent.date > entry.date
        }
        return out
    }
    private var searchedEntries: [Entry] = []
    
    // MARK: public
    public var isSearching = false {
        didSet {
            print("search set to: \(isSearching) in entry data manager")
        }
    }
    public var entryType: EntryType? {
        didSet {
            print("type set to: \(entryType ?? .all) in entry data manager")
        }
    }
    
    //text entries by filter
    public var textEntries: [TextEntryPreview] = [] {
        didSet {
            entryType = .text
        }
    }
    //media entries by filter
    public var mediaEntries: [MediaEntryPreview] = [] {
        didSet {
            entryType = .media
        }
    }
    //link entries by filter
    public var linkEntries: [LinkEntryPreview] = [] {
        didSet {
            entryType = .link
        }
    }
    private var recordingEntries: [LinkEntryPreview] {
        entryType = .recording
        return []
    }
    
    public func setSearchedEntries(_ entries: [Entry], ofType: EntryType) {
        isSearching = true
        searchedEntries = entries
    }
}

extension EntryDataManager {
    public var count: Int {
        if isSearching {
            return searchedEntries.count
        }
        return entries.count
    }
    public var data: [Entry] {
        switch entryType! {
        case .text:
            return textEntries
        case .link:
            return linkEntries
        case .media:
            return mediaEntries
        default:
            return entries
        }
    }
    
    func retrieveCell(with index: IndexPath, tableView: UITableView) -> UITableViewCell? {
        if index.row > count {
            print("index path is unreachable")
            return nil
        }
        
        let current = data[index.row]
        var tableCell: UITableViewCell!
        var identifier = String()
        
        switch current.type {
        case .text:
            tableCell = EntryTextCell(style: .default, reuseIdentifier: EntryTextCell.identifier)
            identifier = EntryTextCell.identifier
        default:
            tableCell = EntryMediaCell(style: .default, reuseIdentifier: EntryMediaCell.identifier)
            identifier = EntryMediaCell.identifier
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index)
        
        return cell
    }
}

