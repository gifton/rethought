//
//  EntryPreview.swift
//  Rethought
//
//  Created by Dev on 4/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol EntryContent {
    var id: String { get set }
    var date: Date { get set }
    var type: EntryType { get }
    var thoughtIcon: String { get }
    var height: CGFloat { get }
}
