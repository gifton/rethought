//
//  ThoughtCardDelegate.swift
//  rethought
//
//  Created by Dev on 1/15/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol ThoughtCardDelegate {
    func updateState(state: ThoughtCardState)
    func startNewEntry(_ type: EntryType)
    func addEntry(_ entry: Entry)
    func buildThought(title: String, icon: ThoughtIcon)
    func didPressSave()
    func addTextEntry(title: String, detail: String)
    func addImageEntry(image: UIImage, detail: String)
    func addLinkEntry(link: EntryLinkObject)
    func addRecordingEntry(title: String, detail: String)
}


enum ThoughtCardState {
    case collapsed
    case cardIsEditing
    case cardIsDoneEditing
}

func cardHeight(_ state: ThoughtCardState) -> CGFloat {
    switch state {
    case .collapsed:
        return 69
    default:
        return 367
    }
}
