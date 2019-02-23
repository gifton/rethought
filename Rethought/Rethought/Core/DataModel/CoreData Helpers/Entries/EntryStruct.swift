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
    init?(link: URL, description: String, image: URL, shorthand: String) {
        self.init()
        self.link = link
        self.image = image
        self.description = description
        self.shorthand = shorthand
    }
    
    var link: URL = URL(string: "https://wesaturate.com")!
    var description: String = ""
    var image: URL = URL(string: "https://wesaturate.com")!
    var shorthand: String = ""
    
    init() {
        
    }
}

protocol EntryLinkObjectDelegate {
    init?(link: URL, description: String, image: URL, shorthand: String)
}

struct EntryCount {
    var text:      Int
    var image:     Int
    var link:      Int
    var recording: Int
    
    init(text: Int, images: Int, recordings: Int, links: TextOutputStream) {
        self.text = text
        self.image = images
        self.link = links
        self.recording = recordings
    }
}
