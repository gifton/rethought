//
//  DashboardDelegate.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit



protocol HomeViewControllerDelegate {
    func dataIsLoaded()
    func userDidTapProfileButton()
    func userDidTapViewAllThoughts()
    func userDidTapViewAllEntries()
    func userDidTapNewThought()
    func userDidTapThought(_ thoughtID: String)
    func userDidTapQuickAddIcon()
    func userBeganQuickAdd()
    func userDidTapOnEntry(_ entryID: String)
}


