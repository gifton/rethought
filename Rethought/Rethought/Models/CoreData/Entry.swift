//
//  Entry+CoreDataProperties.swift
//  Rethought
//
//  Created by Dev on 4/13/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation
import UIKit

@objc(Entry)
public class Entry: NSManagedObject {

    // MARK: Core Data properties
    @NSManaged public var id: String
    @NSManaged public var date: Date
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var type: String
    
    // MARK: Relationships
    @NSManaged public var thought: Thought
    @NSManaged public var note: NoteEntry?
    @NSManaged public var photo: PhotoEntry?
    @NSManaged public var recording: RecordingEntry?
    @NSManaged public var link: LinkEntry?
    
    // MARK: Computed properties
    public var rawPhoto: Data? {
        if let rawimg = photo?.rawPhoto {
            return rawimg
        } else {
            return nil
        }
    }
    
    var computedEntryType: EntryType {
        if note != nil {
            return .note
        } else if photo != nil {
            return .photo
        } else if recording != nil {
            return .recording
        } else if link != nil {
            return .link
        } else {
            return .none
        }
    }
    
    var associatedBuilder: EntryBuilder {
        switch computedEntryType {
        case .note:
            guard let note = self.note else {
                return NoteBuilder.zero
            }
            return NoteBuilder(withNote: note)
        case .link:
            guard let link = self.link else {
                return LinkBuilder.zero
            }
            return LinkBuilder(withEntry: link)
        // TODO: make recording
        default:
            guard let photo = self.photo else {
                print("unable to process photo builder object in associatedBuilder func for entry CD model")
                return PhotoBuilder.zero
            }
            return PhotoBuilder(withEntry: photo)
        }
    }
    
    // return height for content,
    // since notes are variable in size, as are photos, calculations are be made on the string itself
    // links and recordings have fixed heights of 130px
    // max height we want is 250, so never exceed that
    public func heightForContent(width: CGFloat) -> CGFloat {
        if let note = note {
            return max(200, note.minimumHeightForContent(width: width))
        } else if let photo = photo {
            return max(250, photo.minimumHeightForContent(width: width))
        } else if link != nil {
            return 115
        } else {
             return 130
        }
    }
    
    // standard static func returns an entry(including thought relationship)
    static func insert(into context: NSManagedObjectContext, withlocation location: CLLocation?, for thought: Thought) -> Entry {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        let entry: Entry = context.insertObject()
        entry.date = Date()
        entry.id   = "rt-pDB-E\(defaultCount)"
        entry.thought = thought
        
        // save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
    
    // add an entrybuilder-delegated object to entry
    func addBuilder(_ payload: EntryBuilder, moc: NSManagedObjectContext) {
        // depending on payload type, save the proper builder
        switch payload.type {
        case .photo: addPhotoBuilder(payload as? PhotoBuilder, with: moc)
        case .note: addNoteBuilder(payload as? NoteBuilder, with: moc)
        case .link: addLinkBuilder(payload as? LinkBuilder, with: moc)
        case .recording: fatalError(("you havent added a method to save recordings yet"))
        default: break
        }
    }
    
    // prep for deletion by deleting entryContent
    
    
    // static method to create thought with an entrybuilder in its initialization
    static func insertEntry<K: EntryBuilder>(into context: NSManagedObjectContext, location: CLLocation?, payload: K, thought: Thought) -> Entry {
        // init defaults
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        let entry: Entry = context.insertObject()
        entry.date = Date()
        entry.id   = "rt-pDB-E\(defaultCount)"
        entry.type = payload.type.rawValue
        entry.thought = thought
        
        // set entry content
        entry.addBuilder(payload, moc: context)
        
        // save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
}

extension Entry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}

// all link building and adding functions
extension Entry {
    // photos
    func addPhotoBuilder(_ builder: PhotoBuilder?, with moc: NSManagedObjectContext) {
        guard var pb: PhotoBuilder = builder else {
            print ("unable to cast builder as photo")
            return
        }
        pb.entry = self
        let pe: PhotoEntry = PhotoEntry.insert(into: moc, builder: pb)
        photo = pe
        type = EntryType.photo.rawValue
    }
    // links
    func addLinkBuilder(_ builder: LinkBuilder?, with moc: NSManagedObjectContext) {
        guard var lb: LinkBuilder = builder else {
            print("unable to cast builder as photo")
            return
        }
        lb.entry = self
        let le: LinkEntry = LinkEntry.insert(into: moc, builder: lb)
        link = le
        type = EntryType.link.rawValue
    }
    //notes
    func addNoteBuilder(_ builder: NoteBuilder?, with moc: NSManagedObjectContext) {
        guard var nb: NoteBuilder = builder else {
            print("unable to cast builder as note")
            return
        }
        nb.entry = self
        let ne: NoteEntry = NoteEntry.insert(into: moc, builder: nb)
        note = ne
        type = EntryType.note.rawValue
    }
    // recordings
    func addRecordingBuilder( _ builder: RecordingBuilder, with moc: NSManagedObjectContext) {
//        guard var rb: RecordingBuilder = builder else {
//            print("unable to cast builder as recording")
//            return
//        }
//        rb.entry = self
//        let re: RecordingEntry = RecordingEntry.insert(into: moc, builder: rb)
//        recording = re
    }
    
    public func removeSelf() {
        managedObjectContext?.delete(self)
    }
}

