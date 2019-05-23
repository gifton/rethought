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
    
    // standard static func returns an entry
    static func insert(into context: NSManagedObjectContext, withlocation location: CLLocation?, for thought: Thought) -> Entry {
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        let entry: Entry = context.insertObject()
        entry.date = Date()
        entry.id   = "rt-pDB-E\(defaultCount)"
        
        // save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
    
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
    
    
    
    // static method to create thought with a entrybuilder
    static func insertEntry<K: EntryBuilder>(into context: NSManagedObjectContext, location: CLLocation?, payload: K) -> Entry {
        // init defaults
        let defaults = UserDefaults.standard
        let defaultCount = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        var entry: Entry = context.insertObject()
        entry.date = Date()
        entry.id   = "rt-pDB-E\(defaultCount)"
        entry.type = payload.type.rawValue
        
        // set entry content
        sort(payload: payload, for: context, inEntry: &entry)
        
        // save location if available
        if let loc: CLLocation = location {
            entry.latitude  = loc.coordinate.latitude as NSNumber
            entry.longitude = loc.coordinate.longitude as NSNumber
        }
        
        defaults.set(defaultCount + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
    
    private static func sort<T: EntryBuilder>(payload: T, for context: NSManagedObjectContext, inEntry entry: inout Entry) {
        switch payload.type {
        case .photo:
            guard var photoBuilder: PhotoBuilder = payload as? PhotoBuilder else { return }
            photoBuilder.entry = entry
            let photoEntry = PhotoEntry.insert(into: context, builder: photoBuilder)
            entry.photo = photoEntry
        case .link:
            guard var linkBuilder: LinkBuilder = payload as? LinkBuilder else { return }
            linkBuilder.entry = entry
            let linkEntry = LinkEntry.insert(into: context, builder: linkBuilder)
            entry.link = linkEntry
        case .note:
            guard var noteBuilder: NoteBuilder = payload as? NoteBuilder else { return }
            noteBuilder.entry = entry
            let noteEntry = NoteEntry.insert(into: context, builder: noteBuilder)
            entry.note = noteEntry
        case .recording:
            guard var linkBuilder: LinkBuilder = payload as? LinkBuilder else { return }
            linkBuilder.entry = entry
            let linkEntry = LinkEntry.insert(into: context, builder: linkBuilder)
            entry.link = linkEntry
        default:
            break
        }
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
}

