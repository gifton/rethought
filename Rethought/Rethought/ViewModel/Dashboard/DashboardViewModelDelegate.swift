//
//  DashboardViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardViewModelDelegate {
    func getRecentEntries() -> [ReccomendedThought]
    func getThoughts() -> [ThoughtPreview]
    func retrieve(thought id: String) -> Thought?
    func retrieve(entry id: String) -> Entry?
}
