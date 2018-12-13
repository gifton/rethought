//
//  DashboardDelegate.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

//protocol HomeViewDelegate {
//    func userDidTapProfileButton()
//    func userDidTapViewAllThoughts()
//    func userDidTapViewAllEntries()
//    func userDidTapNewThought()
//    func userDidTapThought(_ thought: Thought)
//}

protocol HomeViewControllerDelegate {
    func dataIsLoaded()
    func userDidTapProfileButton()
    func userDidTapViewAllThoughts()
    func userDidTapViewAllEntries()
    func userDidTapNewThought()
    func userDidTapThought(_ thoughtID: String)
}

protocol HomeViewModelDelegate {
    func createNew(_ thought: Thought)
    func destroy(_ thoughtID: Thought)
    func update(_ thought: Thought)
    func getReccomended() -> ThoughtPreviewLarge
    func getRecent() -> [ThoughtPreviewSmall]
}

