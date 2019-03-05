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
    var entryPreviews: [EntryPreview] { get }
    func getThoughts() -> [ThoughtPreview]
    func retrieve(thought id: String) -> Thought?
    func retrieve(entry id: String) -> Entry?
}

