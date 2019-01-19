//
//  Entry.swift
//  rethought
//
//  Created by Dev on 12/8/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


//single entry, all entries are either a link, text, or image

//base level Entry class for identifying entry types
public class Entry {
    public enum EntryType {
        case image
        case text
        case link
        case recording
    }
    
    //standard objects
    public let type: EntryType
    public let id: String
    public let date: Date
    public var description: String
    public var icon: String
    public var thoughtID: String
    
    
    //unique objects
    public var image: UIImage?
    public var title: String?
    public var link: String?
    public var linkImage: UIImage?
    public var linkTitle: String?
    
    //optional values
    public var thoughtTitle: String?
    
    //minimum
    init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String) {
        self.type = type
        self.thoughtID = thoughtID
        self.id = randomString(length: 12)
        self.description = description
        self.date = date
        self.icon = icon
    }
    
    //image type
    convenience init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String, image: UIImage) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        self.image = image
    }
    //link type
    convenience init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String, link: String, linkImage: UIImage, linkTitle: String) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        self.linkImage = linkImage
        self.link = link
        self.linkTitle = linkTitle
        self.thoughtID = thoughtID
    }
    //string type
    convenience init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String, title: String) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        self.title = title
    }
    //link type
    convenience init(type: Entry.EntryType, thoughtID: String, description: String, date: Date, icon: String, linkTitle: String, linkImage: UIImage, link: String, shorthandLink: String) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        self.link = link
        self.linkImage = linkImage
        self.linkTitle = linkTitle
    }
    //empty entry
    convenience init(title: String?) {
        self.init(type: .text, thoughtID: "nil", description: "not available", date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "🚫")
    }
    
}

extension Entry {
    public func sendNewThoughtToDB() {
        print ("sent \(self) to DB")
    }
    public func removeThoughtFromDB() {
        print ("removed thought: \(String(describing: self.title)) from db")
    }
    
    public func updateThought(thoughtID: String, payload: Thought) {
        print (thoughtID, "Updated!")
    }
}
