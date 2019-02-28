//
//  RootViewModelDelegate.swift
//  rethought
//
//  Created by Dev on 2/27/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit


protocol RootViewModelDelegate: UITableViewDelegate, UICollectionViewDelegate, UITableViewDataSource, UICollectionViewDataSource {
    func getRecentEntries() -> [ReccomendedThought]
    func getThoughts() -> [DashboardThought]
    func retrieve(thought id: String) -> Thought?
    func retrieve(entry id: String) -> Entry?
}

