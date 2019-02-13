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
    
    var preview: [EntryPreview]?
    
    //standard objects
    public var type: EntryType
    public var id: String!
    public var date: Date
    public var detail: String
    public var thoughtID: String!
    
    //unique objects
    public var image        : UIImage?
    public var title        : String?
    public var link         : String?
    public var linkImage    : UIImage?
    public var linkTitle    : String?
    
    //optional values
    public var thoughtTitle: String?
    
    //minimum
    init(type: EntryType, thoughtID: String, detail: String, date: Date) {
        let defaults   = UserDefaults.standard
        let newID: Int = defaults.integer(forKey: UserDefaults.Keys.entryID) + 1
        self.type = type
        self.thoughtID = thoughtID
        self.id = "E\(newID)"
        self.detail = detail
        self.date = date
        
        defaults.set(newID, forKey: UserDefaults.Keys.entryID)
    }
    
    //image type
    convenience init(type: EntryType, thoughtID: String, detail: String, date: Date, image: UIImage) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date)
        self.image = image
    }
    //link type
    convenience init(type: EntryType, thoughtID: String, detail: String, date: Date, link: String, linkImage: UIImage, linkTitle: String) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date)
        self.linkImage = linkImage
        self.link = link
        self.linkTitle = linkTitle
        self.thoughtID = thoughtID
    }
    //string type
    convenience init(type: EntryType, thoughtID: String, detail: String, date: Date, title: String) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date)
        self.title = title
    }
    //link type
    convenience init(type: Entry.EntryType, thoughtID: String, detail: String, date: Date, linkTitle: String, linkImage: UIImage, link: String) {
        self.init(type: type, thoughtID: thoughtID, detail: detail, date: date)
        self.link          = link
        self.linkImage     = linkImage
        self.linkTitle     = linkTitle

    }
    //entryModel init
    convenience init(entryModel: EntryModel) {
        self.init(title: nil)
        
        self.id        = entryModel.entryID
        self.date      = entryModel.createdAt as Date
        self.thoughtID = entryModel.thoughtModel.id
        self.detail    = entryModel.detail
        
        //check entry type
        //link
        if entryModel.link != nil {
            self.type = .link
            guard let link      = entryModel.link else {
                print("could not recieve link from model")
                return
            }
            guard let linkTitle = entryModel.linkTitle else {
                print("could not recieve link title from model")
                return
            }
            guard let linkImage = entryModel.linkImage else {
                print("could not recieve link image from model")
                return
            }

            self.link = link
            self.linkTitle = linkTitle
            self.linkImage = UIImage(data: linkImage)
        //image
        } else if entryModel.image != nil {
            self.type = .image
            guard let image       = entryModel.image else {
                print("could not recieve image from model")
                return
            }
            self.image = UIImage(data: image)
        //text
        } else {
            self.type = .text
            self.title = entryModel.title
        }
    }
    //empty entry
    convenience init(title: String?) {
        self.init(type: .text, thoughtID: "nil", detail: "not available", date: Date(timeIntervalSinceNow: TimeInterval.init(exactly: 1000)!))
    }
}

extension Entry {
    public func sendNewThoughtToDB() {
        print ("sent \(self) to DB")
    }
    public func removeThoughtFromDB() {
        print ("removed from db")
    }
    
    public func updateThought(thoughtID: String, payload: Thought) {
        print (thoughtID, "Updated!")
    }
}
