//
//  DashboardDelegate.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardDelegate {
    func userDidTapProfileButton()
    func userDidTapViewAllThoughts()
    func userDidTapViewAllEntries()
    func userDidTapNewThought()
    func userDidTapThought(_ thought: Thought)
}
