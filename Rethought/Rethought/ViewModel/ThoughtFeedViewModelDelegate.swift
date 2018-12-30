//
//  ThoughtFeedModelDelegate.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol ThoughtFeedViewModelDelegate {
    func createNew(_ thought: Thought)
    func destroy(_ thoughtID: Thought)
    func update(_ data: Any, component: ThoughtComponent, id: String)
    func getEntries(for thoughtID: String) -> [Entry]
    func getSimilarThoughts(for thoughtID: String) -> [ThoughtPreviewSmall]
}


