//
//  ThinkDelegate.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation


protocol ThinkDelegate {
    func thoughtComponentsCompleted()
    func createEntry(of type: EntryType)
    func showKeyboard()
    func hideKeyboard()
}
