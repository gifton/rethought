//
//  DashboardDelegate.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol DashboardDelegate {
    func changeSize(size: ThoughtCardState)
    var context: NSManagedObjectContext { get set }
    func userTapped(on thoughtID: String)
    func userStartedNewFastThought()
    func saveNewThought(_ thought: Thought)
    func updateInputs()
}
