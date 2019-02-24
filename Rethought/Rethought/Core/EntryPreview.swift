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
    let id         : String
    var ThoughtID  : String
    let date       : Date
    var thoughtIcon: ThoughtIcon
    
    //optional Values
    var title       : String?
    var detail      : String
    var link        : EntryLinkObject?
    var type        : EntryType?
    var image       : UIImage
    var thoughtTitle: String?
    
    init(entry: Entry) {
        self.ThoughtID = entry.thought.id
        self.date = entry.date
        
        //depending on entry type, initiate proper variables
        switch entry.type {
        case .image:
            self.title = entry.detail ?? "No description available"
            self.image = entry.image ?? UIImage.placeholder(type: "image")
            self.type  = .image
        case .text:
            self.title  = entry.title ?? "No title available"
            self.detail = entry.detail ?? "No detail available"
            self.type   = .text
        default:
            if let link = entry.link {
                self.link = link
            } else {
                fatalError("unable to extract link object from entry")
            }
            
            self.type  = .link
        }
        
        self.id          = entry.id
    }
}
