//
//  EntryModel+CoreDataClass.swift
//  rethought
//
//  Created by Dev on 2/3/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(EntryModel)
public class EntryModel: ThoughtModel {
    func setModel(entry: Entry, thought: ThoughtModel) {
        let date_pre   = entry.date as NSDate?
        guard let date = date_pre as NSDate? else {
            print("error calculating date")
            return
        }
        
        self.createdAt = date
        self.type      = entry.type.rawValue
        self.entryDate = date
        self.entryID   = entry.id
        self.detail    = entry.detail
        
        switch entry.type {
        case .text:
            self.title = entry.title!
        case .image:
            self.image = entry.image!.pngData()
        default:
            self.link = entry.link!
            self.linkImage = entry.linkImage!.pngData()
            self.linkTitle = entry.linkTitle!
        }
        
        self.title = thought.title
        self.icon = thought.icon
        self.id = thought.id
        self.thoughtModel = thought
        
        print("self from entryModel:")
        print(self)
    }
}
