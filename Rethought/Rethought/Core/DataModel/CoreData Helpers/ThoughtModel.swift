//
//  ThoughtModel.swift
//  rethought
//
//  Created by Dev on 2/21/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class Thought: NSManagedObject {
    @NSManaged fileprivate(set) var date:    Date
    @NSManaged fileprivate(set) var id:      String
    @NSManaged fileprivate(set) var title:   String
    @NSManaged fileprivate(set) var rawIcon: String
    
    var icon: ThoughtIcon {
        get {
            return ThoughtIcon(rawIcon)
        }
        set {
            self.rawIcon = newValue.icon
        }
    }
}
