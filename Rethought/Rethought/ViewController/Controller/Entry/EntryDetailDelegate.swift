//
//  EntryDetailDelegate.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation

protocol EntryDetailDelegate {
    var entry: Entry { get set }
    func returnHome()
}
