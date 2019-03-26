
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
