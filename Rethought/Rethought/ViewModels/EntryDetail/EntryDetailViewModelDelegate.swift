//
//  EntryDetailViewModelDelegate.swift
//  Rethought
//
//  Created by Dev on 6/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol EntryDetailViewModelDelegate {
    init(withEntry entry: Entry, _ moc: NSManagedObjectContext)
    func deleteEntry()
    func save()
    var entryType: EntryType { get }
    var heightForContent: CGFloat { get }
}
