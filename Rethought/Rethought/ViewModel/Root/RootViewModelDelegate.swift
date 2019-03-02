//
//  RootViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 2/27/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


protocol RootViewModelDelegate {
    func getRecentEntries() -> [EntryPreview]
    func getThoughts() -> [ThoughtPreview]
    func retrieve(thought id: String) -> Thought?
    func retrieve(entry id: String) -> Entry?
}

