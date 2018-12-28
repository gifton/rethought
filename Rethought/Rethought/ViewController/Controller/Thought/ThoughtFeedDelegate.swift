//
//  ThoughtFeedDelegate.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol ThoughtFeedDelegate {
    func userTapped(on thought: Thought)
    func returnHome()
    var thoughtPreviews: ThoughtPreviewLarge { get set }
}
