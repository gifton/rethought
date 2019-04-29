//
//  MSGBoardDelegate.swift
//  Rethought
//
//  Created by Dev on 4/28/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

protocol MSGBoardDelegate {
    // TODO: add MSGBoard funcs and vars
    func addEntry<K: EntryBuilder>(_ payload: K, completion: () -> Void)
    func addThought(_ payload: ThoughtPreview, completino: () -> Void)
    var currentSize: CGSize { get set }
}

protocol MSGBoardResponse {
    var content: String { get }
}

