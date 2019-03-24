//
//  EntryProtocol.swift
//  Rethought-project
//
//  Created by Dev on 3/10/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData

protocol Entry {
    var id: String { get set }
    var date: Date { get set }
    var type: EntryType { get }
    var thoughtIcon: String { get }
}

enum EntryType {
    case text
    case media
    case link
    case recording
    case all
    
    static func exhaustiveList() -> [EntryType] {
        return [text, media, link, recording, all]
    }
}
