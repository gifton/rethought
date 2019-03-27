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
        
        return out
    }
    private var searchedEntries: [Entry] = []
    
    // MARK: public
    public var isSearching = false
    public var entryType: EntryType?
    
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
}

