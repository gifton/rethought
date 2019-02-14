//@NSManaged public var detail: String
//@NSManaged public var entryDate: NSDate
//@NSManaged public var entryID: String
//@NSManaged public var entryTitle: String?
//@NSManaged public var image: Data?
//@NSManaged public var link: String?
//@NSManaged public var linkImage: Data?
//@NSManaged public var linkTitle: String?
//@NSManaged public var recording: Data?
//@NSManaged public var type: String
//@NSManaged public var thoughtModel: ThoughtModel

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
        
        print("ID from entryModel: \(self.entryID)")
    }
    
    public enum EntryType: String {
        case image = "IMAGE"
        case text = "TEXT"
        case link = "LINK"
        case recording = "RECORDING"
    }
    
    var date: Date? {
        get {
            return self.createdAt as Date
        }
        set {
            self.createdAt = newValue as NSDate? ?? NSDate()
        }
    }
    
    public var eType: EntryType {
        get {
            if self.link != nil {
                return .link
            } else if self.image != nil {
                return .image
            } else if self.recording != nil {
                return .recording
            } else {
                return .text
            }
        }
    }
}
