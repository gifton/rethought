//
//  HomeViewModelDelegate.swift
//  Rethought
//
//  Created by Dev on 5/18/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewModelDelegate: NSObject {
    var entries: [Entry] { get }
    var reccomendedThoughts: [Thought] { get }
    func requestDeletion(forthought thought: Thought)
    func showThought(forEntry entry: Entry)
    func showThought(_ id: String)
    func showEntry(_ id: String)
}
