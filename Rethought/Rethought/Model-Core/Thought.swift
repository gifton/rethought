//All posts, no matter the type must have these basic needs

import Foundation
import UIKit
import Smile

//thought is parent object holding all entries
public class Thought: ThoughtDelegate {
    
    public func addNew(entry: Entry) {
        self.entries.append(entry)
        switch entry.type {
        case .link:
            guard var count: Int = entryCount["links"] else { return }
            count += 1
        case .text:
            guard var count: Int = entryCount["text"] else { return }
            count += 1
        default:
            guard var count: Int = entryCount["media"] else { return }
            count += 1
        }
    }
    public func remove(entry: Entry) {
        if let mark = entries.index(where: { $0.id == entry.id }) {
            entries.remove(at: mark)
        } else {
            return
        }
        updateLastEdited()
    }
    
    convenience init(_ empty: String = "empty") {
        self.init(title: "nil", description: "nil", icon: "nil", date: Date.init())
    }
    

    //  change later to include fontawesomekit icons
    public enum Icon {
        case yes
        case no
    }
    //  all thought objects
    public var title: String
    public var description: String
    public var icon: String
    public var entries: [Entry] = []
    public var date: Date
    public var lastEdited: Date?
    public var entryCount: [String:Int] = ["links": 0, "text": 0, "media":0]
    public var ID: String = randomString(length: 12)
    
    //  minimum req's to build new thought
    public init(title: String, description: String, icon: String, date: Date) {
        self.title = title
        self.description = description
        self.icon = icon
        self.date = date
        self.ID = randomString(length: 12)
    }
    //  thoughts dont HAVE top have entries from the start, so if they do, use this function to set its entries
    public convenience init(title: String, description: String, icon: String, date: Date, entries: [Entry]) {
        self.init(title: title, description: description, icon: icon, date: date)
        self.entries = entries
        updateLastEdited()
    }
    
    //  last edited func refactored to be able to be called when new entry is added,
    //  and when new thought is made that comes with a list of thoughts
    private func updateLastEdited() {
        let lastEntry = self.entries.last
        self.lastEdited = lastEntry?.date
        var linkCount: Int = 0
        var textCount: Int = 0
        var mediaCount: Int = 0
        
        for entry in entries {
            switch entry.type {
            case .image:
                mediaCount += 1
            case .text:
                textCount += 1
            case .link:
                linkCount += 1
            }
        }
        entryCount["links"] = linkCount
        entryCount["tex"] = textCount
        entryCount["media"] = mediaCount
    }
}

public protocol ThoughtDelegate {
    func remove(entry: Entry)
    func addNew(entry: Entry)
    
}
