//
//  ConversationDelegate.swift
//  rethought
//
//  Created by Dev on 3/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol ConversationDelegate {
    func resetLayout(animated: Bool)
    func beginEditingThought()
    func checkForCompletion()
    func thoughtComponentsComplete()
    func save()
    var imageViewController: UIViewController { get set }
    var textViewController: UIViewController { get set }
    var linkViewController: UIViewController { get set }
    var size: CGFloat { get set }
    var entrViewSize: CGSize { get }
    var bottomOfArea: CGFloat { get }
    
}

enum ConversationViews {
    case thought
    case entryBar
    case textEntry
    case imageEntry
    case linkEntry
    case recordingEntry
}
