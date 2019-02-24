//
//  ThoughtModel.swift
//  rethought
//
//  Created by Dev on 2/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class Thought: NSManagedObject {
    @NSManaged fileprivate(set) var date:    Date
    @NSManaged fileprivate(set) var id:      String
    @NSManaged fileprivate(set) var title:   String
    @NSManaged fileprivate(set) var rawIcon: String
    
    @NSManaged fileprivate(set) var entries: Set<Entry>
    
    var icon: ThoughtIcon {
        get {
            return ThoughtIcon(rawIcon)
        }
        set {
            self.rawIcon = newValue.icon
        }
    }
    
    //MARK: find wether first or last is most recent
    var lastEdited: Date {
        guard let recentEntry: Entry = entries.first else { return date}
        return recentEntry.date
    }
    
    var allEntries: [Entry]? {
        get {
            guard let entries: Entry = entries else { return nil}
            return entries
        }
    }
    
    var entryCount: EntryCount {
        get {
            let texts: Int = entries.filter( {$0.type == EntryType.text}).count
            let images: Int = entries.filter( {$0.type == EntryType.image}).count
            let recordings: Int = entries.filter( {$0.type == EntryType.recording}).count
            let links: Int = entries.filter( {$0.type == EntryType.link}).count
            return EntryCount(text: texts, images: images, recordings: recordings, links: links)
        }
    }
}
extension Thought: Managed {
    
}
