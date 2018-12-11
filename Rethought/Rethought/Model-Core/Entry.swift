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
    }
    
    //standard objects
    public let type: EntryType
    public let id: String
    public let date: Date
    public var description: String
    public var icon: String
    public var thoughtID: String
    
    //unique objects
    public var images: [UIImage] = []
    public var title: String?
    public var link: String?
    public var linkImage: UIImage?
    public var linkTitle: String?
    
    init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String) {
        self.type = type
        self.thoughtID = thoughtID
        self.id = randomString(length: 12)
        self.description = description
        self.date = date
        self.icon = icon
    }
    convenience init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String, images: [UIImage]) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        for image in images {
            self.images.append(image)
        }
    }
    convenience init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String, link: String, linkImage: UIImage, linkTitle: String) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        self.linkImage = linkImage
        self.link = link
        self.linkTitle = linkTitle
        self.thoughtID = thoughtID
    }
    convenience init(type: EntryType, thoughtID: String, description: String, date: Date, icon: String, title: String) {
        self.init(type: type, thoughtID: thoughtID, description: description, date: date, icon: icon)
        self.title = title
    }
}