//
//  EntryPreview.swift
//  rethought
//
//  Created by Dev on 12/13/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//model for entry previews in dashboard (tableView cells (indexPath.row > 0))
struct EntryPreview {
    //standard objects
    let id: String
    var ThoughtID: String
    let date: Date
    var image: UIImage?
    var title: String
    
    //optional Values
    var detail: String?
    var link: String?
    var type: Entry.EntryType
    var thoughtIcon: ThoughtIcon?
    public var thoughtTitle: String?
    
    init(entry: Entry) {
        self.ThoughtID = entry.thoughtID
        self.date = entry.date
        //depending on entry type, initiate proper variables
        switch entry.type {
        case .image:
            self.title = entry.detail
            self.image = entry.image!
            self.type = .image
        case .text:
            self.title = entry.title ?? "This is the title"
            self.detail = entry.detail
            self.type = .text
        default:
            self.title = entry.linkTitle!
            self.link = entry.link!
            self.image = entry.image!
            self.type = .link
        }
        self.id = entry.id
        self.thoughtIcon = ThoughtIcon(entry.icon)
    }
}
