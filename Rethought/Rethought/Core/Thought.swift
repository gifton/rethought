//All posts, no matter the type must have these basic needs

import Foundation
import UIKit
import Smile

//thought is parent object holding all entries
public class Thought {
    
    public func addNew(entry: Entry) {
        self.entries.append(entry)
        self.updateCounts()
    }
    
    convenience init() {
        self.init(title: "nil", icon: "nil", date: Date.init())
    }
    
    //  all thought objects
    public var title: String
    public var icon: String
    public var entries: [Entry] = []
    public var createdAt: Date
    public var lastEdited: Date
    public var entryCount: [String: Int] = ["links": 0, "entries": 0, "media":0, "audio": 0]
    public var ID: String = randomString(length: 12)
    
    //  minimum req's to build new thought
    public init(title: String, icon: String, date: Date) {
        self.title = title
        self.icon = icon
        self.createdAt = date
        self.ID = randomString(length: 12)
        self.lastEdited = entries.last?.date ?? date
    }
    //  thoughts dont have to have entries from the start, so if they do, use this function to set its entries
    public convenience init(title: String, icon: String, date: Date, entries: [Entry]) {
        self.init(title: title, icon: icon, date: date)
        self.entries = entries
        updateCounts()
    }
    
    //init for entryModel
    public convenience init( thoughtModel: ThoughtModel) {
        self.init()
        print(thoughtModel)
        guard let entries = thoughtModel.entryModels!.allObjects as? [Entry] else { return }
        entries.forEach { ent in
            ent.thoughtID = thoughtModel.id
        }
        
        self.title      = thoughtModel.title
        self.icon       = thoughtModel.icon
        self.createdAt  = Date()
        self.lastEdited = Date() 
        self.ID         = thoughtModel.id
        self.entries    = entries
        updateCounts()
    }
    
    //  last edited func refactored to be able to be called when new entry is added,
    //  and when new thought is made that comes with a list of thoughts
    private func updateCounts() {
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
            default:
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
