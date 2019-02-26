//
//  EntryModel.swift
//  rethought
//
//  Created by Dev on 2/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SwiftLinkPreview
import CoreLocation

final class Entry: NSManagedObject {
    //core data attributes
    @NSManaged fileprivate(set) var id:           String
    @NSManaged fileprivate(set) var detail:       String?
    @NSManaged fileprivate(set) var title:        String?
    @NSManaged fileprivate(set) var rawLink:      String?
    @NSManaged fileprivate(set) var date:         Date
    @NSManaged fileprivate(set) var rawImage:     Data?
    @NSManaged fileprivate(set) var rawRecording: Data?
    
    @NSManaged fileprivate var latitude:          NSNumber?
    @NSManaged fileprivate var longitude:         NSNumber?
    
    // MARK: public facing varibales
    @NSManaged public fileprivate(set) var thought: Thought
    
    //calculated values
    //image returns UIImage, consider creating custom data transformer
    var image: UIImage? {
        get {
            guard let rawImage = self.rawImage else { return nil}
            guard let image = UIImage(data: rawImage) else { return nil}
            return image
        }
        set {
            guard let nv: UIImage = newValue else { fatalError()}
            self.rawImage = nv.pngData()
        }
    }
    
    //convert LinkObject to string for storage, or return LinkObject for views to display
    var link: EntryLinkObject? {
        get {
            guard let rawLink: String = self.rawLink else { return nil}
            var linkEntry = EntryLinkObject()
            let slp = SwiftLinkPreview(session: .shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
            slp.preview(rawLink,
                        onSuccess: { result in
                            
                            //image validation and setter
                            if let imgUrl: URL = URL(string: result[SwiftLinkResponseKey.image] as! String) {
                                linkEntry.image = imgUrl
                            } else {
                                self.image = UIImage()
                            }
                            
                            //set link objects
                            linkEntry.shorthand = result[SwiftLinkResponseKey.canonicalUrl] as? String ?? "Not available"
                            linkEntry.description = result[SwiftLinkResponseKey.description] as? String ?? "Not available"
                            guard let link: URL = URL(string: result[SwiftLinkResponseKey.finalUrl] as! String) else {
                                return
                            }
                            linkEntry.link = link
            },
                        onError: { error in
                            print("\(error)")
            })
            
            return linkEntry
        }
        set {
            guard let link: URL = newValue?.link else {
                self.rawLink = "https://wesaturate.com"
                return
            }
            self.rawLink = "\(link)"
        }
    }
    
    //return entrytype depending on what data is currently present
    var type: EntryType {
        get {
            if self.image != nil {
                return .image
            } else if self.link != nil {
                return .link
            } else if self.rawRecording != nil {
                return .recording
            } else {
                return .text
            }
        }
    }
    
    //return location as CLLocation
    public var location: CLLocation? {
        guard let lat = latitude, let lon = longitude else { return nil }
        return CLLocation(latitude: lat.doubleValue, longitude: lon.doubleValue)
    }
    
    //set new image entry
    public static func insertNewImageEntry(into context: NSManagedObjectContext,
                                           image: UIImage,
                                           detail: String,
                                           thought: Thought) -> Entry {
        
        let entry: Entry = context.insertObject()
        
        //get ID number count from defaults, and increment
        let defaults = UserDefaults.standard
        let entryNum: Int = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        //set variables
        entry.id = "E\(entryNum)"
        entry.image      = image
        entry.detail     = detail
        entry.date       = Date()
        entry.thought    = thought
        
        defaults.set(entryNum + 1, forKey: UserDefaults.Keys.entryID)
        
        return entry
    }
    
    //set new link entry
    public static func insertNewLinkEntry(into context: NSManagedObjectContext,
                                          linkObject: EntryLinkObject,
                                          thought: Thought) -> Entry {
        
        let entry: Entry = context.insertObject()
        
        //get ID number count from defaults, and increment
        let defaults = UserDefaults.standard
        let entryNum: Int = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        //set variables
        entry.id      = "E\(entryNum)"
        entry.link    = linkObject
        entry.date    = Date()
        entry.thought = thought
        entry.title   = linkObject.title
        
        defaults.set(entryNum + 1, forKey: UserDefaults.Keys.entryID)
        return entry
        
    }
    
    //set new Text entry
    public static func insertNewTextEntry(into context: NSManagedObjectContext,
                                          title: String,
                                          detail: String,
                                          thought: Thought) -> Entry {
        
        let entry: Entry = context.insertObject()
        
        //get ID number count from defaults, and increment
        let defaults = UserDefaults.standard
        let entryNum: Int = defaults.integer(forKey: UserDefaults.Keys.entryID)
        
        //set variables
        entry.id      = "E\(entryNum)"
        entry.title   = title
        entry.detail  = detail
        entry.thought = thought
        
        defaults.set(entryNum + 1, forKey: UserDefaults.Keys.entryID)
        return entry
    }
}

extension Entry: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(date), ascending: false)]
    }
}
