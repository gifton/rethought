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
    func userDidTapViewAllThoughts()
    func userDidTapThought(_ thoughtID: String)
    func userDidTapOnEntry(_ entryID: String)
    func userTappedNewThought(state: thoughtDrawerHeight)
    func userSavedNewThought(success: Bool)
}


