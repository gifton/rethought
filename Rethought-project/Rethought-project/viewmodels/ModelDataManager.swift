
import Foundation
import UIKit

//controlls wether search results or standard thoughts / entries are returned to a collectionView
class ModelDataManager: NSObject {
    override init() {
        super.init()
    }
    
    // MARK: Priavte
    
    private var thoughts: [ThoughtPreview] = []
    private var searchedThoughts: [ThoughtPreview] = []
    
    private var entries: [Entry] = []
    private var searchedEntries: [Entry] = []
    
    private var textEntries: [TextEntryPreview] {
        let texts = entries.filter { (entry) -> Bool in
            entry.type == EntryType.text
        }
        var output = [TextEntryPreview]()
        texts.forEach { (entry) in
            output.append(TextEntryPreview(entry as! TextEntry))
        }
        return output
    }
    private var mediaEntries: [MediaEntryPreview] {
        let entries = self.entries.filter { (entry) -> Bool in
            entry.type == EntryType.media
        }
        var output = [MediaEntryPreview]()
        entries.forEach { (entry) in
            output.append(MediaEntryPreview(entry as! MediaEntry))
        }
        return output
    }
    private var linkEntries: [LinkEntryPreview] {
        let entries = self.entries.filter { (entry) -> Bool in
            entry.type == EntryType.link
        }
        var output = [LinkEntryPreview]()
        entries.forEach { (entry) in
            output.append(LinkEntryPreview(entry as! LinkEntry))
        }
        return output
    }
    private var recordingEntries: [LinkEntryPreview] {
        
        return []
    }
    
    // MARK: public
    
    public var isSearching = false
    public var dataType: String?
    public var entryType: EntryType?
    
    
    public func searchedThoughts(_ thoughts: [Thought]) {
        isSearching = true
        dataType = "THOUGHT"
        searchedThoughts.removeAll()
        for t in thoughts {
            print(t.title)
            searchedThoughts.append(ThoughtPreview(thought: t))
        }
    }
    
    public func setThoughts(_ thoughts:  [Thought]) {
        isSearching = false
        dataType = "THOUGHT"
        self.thoughts.removeAll()
        for t in thoughts {
            self.thoughts.append(ThoughtPreview(thought: t))
        }
    }
    
    public func setEntries(_ entries: [Entry], type: EntryType) {
        isSearching = false
        dataType = "ENTRY"
        entryType = type
        self.entries = entries
    }
    public func searchedEntries(_ entries: [Entry]) {
        isSearching = true
        dataType = "ENTRY"
        self.searchedEntries = entries
    }
    
    public var thoughtData: [ThoughtPreview] {
        
        get {
            if isSearching {
                return searchedThoughts
            }
            return thoughts
        }
    }
    
    public var count: Int {
        if dataType == "THOUGHT" {
            if isSearching {
                return searchedThoughts.count
            }
            return thoughts.count
        } else {
            if isSearching {
                return searchedEntries.count
            }
            return entries.count
        }
    }
    
    public var entryData: [Entry] {
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
