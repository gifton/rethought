//All posts, no matter the type must have these basic needs

import Foundation
import UIKit
import Smile

//thought is parent object holding all entries
public class Thought {
    
//    public func addNew(entry: Entry) {
//        self.entries.append(entry)
//        self.updateLastEdited()
//    }
//    public func remove(entry: Entry) {
//        if let mark = entries.index(where: { $0.id == entry.id }) {
//            entries.remove(at: mark)
//        } else {
//            return
//        }
//        updateLastEdited()
//    }
//
//    public func update(thought: Thought) {
//        self.title = thought.title
//        self.description = thought.description
//        self.icon = thought.icon
//        self.updateLastEdited()
//    }
    
    convenience init() {
        self.init(title: "nil", icon: "nil", date: Date.init())
    }
    
    //  all thought objects
    public var title: String
    public var icon: String
    public var entries: [Entry] = []
    public var date: Date
    public var lastEdited: Date
    public var entryCount: [String:Int] = ["links": 0, "entries": 0, "media":0]
    public var ID: String = randomString(length: 12)
    
    //  minimum req's to build new thought
    public init(title: String, icon: String, date: Date) {
        self.title = title
        self.icon = icon
        self.date = date
        self.ID = randomString(length: 12)
        self.lastEdited = Date.init()
    }
    //  thoughts dont have to have entries from the start, so if they do, use this function to set its entries
    public convenience init(title: String, icon: String, date: Date, entries: [Entry]) {
        self.init(title: title, icon: icon, date: date)
        self.entries = entries
        updateLastEdited()
    }
    
    //  last edited func refactored to be able to be called when new entry is added,
    //  and when new thought is made that comes with a list of thoughts
    private func updateLastEdited() {
        let lastEntry = self.entries.last
        guard let lastDate: Date? = lastEntry?.date else { return }
        self.lastEdited = lastDate ?? Date.init()
        
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
    
    public func setID(_ id: String) {
        self.ID = id
    }
}
