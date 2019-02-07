//
//  EntryModel+CoreDataProperties.swift
//  rethought
//
//  Created by Dev on 2/3/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension EntryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntryModel> {
        return NSFetchRequest<EntryModel>(entityName: "EntryModel")
    }
    
    func setModel(entry: Entry) {
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
        
        print("self from entryModel:")
        print(self)
    }

    @NSManaged public var type: String
    @NSManaged public var entryDate: NSDate
    @NSManaged public var entryID: String
    @NSManaged public var detail: String?
    @NSManaged public var entryTitle: String?
    @NSManaged public var image: Data?
    @NSManaged public var link: String?
    @NSManaged public var linkImage: Data?
    @NSManaged public var linkTitle: String?
    @NSManaged public var recording: Data?
    @NSManaged public var thoughtModel: ThoughtModel?
}
