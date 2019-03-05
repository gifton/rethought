//
//  EntryLinkStruct.swift
//  rethought
//
//  Created by Dev on 2/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

struct EntryLinkObject: EntryLinkObjectDelegate {
    init?(link: URL, description: String, image: URL, shorthand: String, title: String) {
        self.init()
        self.link = link
        self.image = image
        self.detail = description
        self.shorthand = shorthand
        self.title = title
    }
    
    var link: URL           = URL(string: "https://wesaturate.com")!
    var detail: String = ""
    var image: URL          = URL(string: "https://wesaturate.com")!
    var shorthand: String   = ""
    var title: String       = ""
    
    init() {
        
    }
}

protocol EntryLinkObjectDelegate {
    init?(link: URL, description: String, image: URL, shorthand: String, title: String)
}

struct EntryCount {
    var text:      Int
    var image:     Int
    var link:      Int
    var recording: Int
    
    init(text: Int, images: Int, recordings: Int, links: Int) {
        self.text = text
        self.image = images
        self.link = links
        self.recording = recordings
    }
}
