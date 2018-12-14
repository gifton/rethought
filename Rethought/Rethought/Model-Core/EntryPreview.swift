//
//  EntryPreview.swift
//  rethought
//
//  Created by Dev on 12/13/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct EntryPreview {
    //standard objects
    let ThoughtID: String
    let date: Date
    var images: [UIImage] = []
    var title: String
    
    var description: String?
    var link: String?
    var type: Entry.EntryType
    
    init(entry: Entry) {
        self.ThoughtID = entry.thoughtID
        self.date = entry.date
        switch entry.type {
        case .image:
            self.title = entry.description
            self.images = entry.images
            self.type = .image
        case .text:
            self.title = entry.title ?? "This is the title"
            self.description = entry.description
            self.type = .text
        case .link:
            self.title = entry.linkTitle!
            self.link = entry.link!
            self.images.append(entry.linkImage!)
            self.type = .link
        }
    }
    var imageCount: Int? {
        return self.images.count
    }
}
