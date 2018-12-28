//
//  HomeViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate {
    func createNew(_ thought: Thought)
    func destroy(_ thoughtID: Thought)
    func update(_ thought: Thought)
    func getReccomendedThought() -> ThoughtPreviewLarge
    func getRecentThoughts() -> [ThoughtPreviewSmall]
}
