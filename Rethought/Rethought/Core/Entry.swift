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
    public enum EntryType: String {
        case image = "IMAGE"
        case text = "TEXT"
        case link = "LINK"
        case recording = "RECORDING"
    }
    
    //standard objects
    public var type: EntryType
    public var id: String!
    public var date: Date
    public var detail: String
    public var icon: String
    public var thoughtID: String
    
    
    //unique objects
    public var image        : UIImage?
    public var title        : String?
    public var link         : String?
    public var linkImage    : UIImage?
    public var linkTitle    : String?
    public var shorthandLink: String?
    
    //optional values
    public var thoughtTitle: String?
    
    //minimum
    init(type: EntryType, thoughtID: String, detail: String, date: Date, icon: String) {
        self.type = type
        self.thoughtID = thoughtID
        self.id = randomString(length: 12)
        self.detail = detail
        self.date = date
        self.icon = icon
    }
    
    //image type
    convenience init(type: EntryType, thoughtID: String, detail: String, date: Date, icon: String, image: UIImage) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date, icon: icon)
        self.image = image
    }
    //link type
    convenience init(type: EntryType, thoughtID: String, detail: String, date: Date, icon: String, link: String, linkImage: UIImage, linkTitle: String) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date, icon: icon)
        self.linkImage = linkImage
        self.link = link
        self.linkTitle = linkTitle
        self.thoughtID = thoughtID
    }
    //string type
    convenience init(type: EntryType, thoughtID: String, detail: String, date: Date, icon: String, title: String) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date, icon: icon)
        self.title = title
    }
    //link type
    convenience init(type: Entry.EntryType, thoughtID: String, detail: String, date: Date, icon: String, linkTitle: String, linkImage: UIImage, link: String, shorthandLink: String) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date, icon: icon)
        self.link          = link
        self.linkImage     = linkImage
        self.linkTitle     = linkTitle
        self.shorthandLink = shorthandLink
    }
    //entryModel init
    convenience init(entryModel: EntryModel) {
        self.init(title: nil)
        //necessary parts
        guard let detail    = entryModel.detail else { return }
        guard let id        = entryModel.entryID else { return }
        guard let date      = entryModel.entryDate else { return }
        guard let thoughtID = entryModel.id else { return }
        
        self.detail = detail
        self.id = id
        self.date = date
        self.thoughtID = thoughtID
        
        //check entry type
        //link
        if entryModel.link != nil {
            self.type = .link
            guard let link      = entryModel.link else { return }
            guard let linkSH    = entryModel.shorthandLink else { return }
            guard let linkTitle = entryModel.linkTitle else { return }
            guard let linkImage = entryModel.linkImage else { return }
            
            self.link = link
            self.shorthandLink = linkSH
            self.linkTitle = linkTitle
            self.linkImage = UIImage(data: linkImage)
            return
        //image
        } else if entryModel.image != nil {
            self.type = .image
            guard let image       = entryModel.image else { return }
            guard let detail     = entryModel.detail else { return }
            
            self.image = UIImage(data: image)
            self.detail = detail
            return
        //text
        } else {
            guard let title = entryModel.title else { return }
            self.title = title
            return
        }
    }
    //empty entry
    convenience init(title: String?) {
        self.init(type: .text, thoughtID: "nil", detail: "not available", date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!), icon: "🚫")
    }
    
    var preview: [EntryPreview]?
    
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
