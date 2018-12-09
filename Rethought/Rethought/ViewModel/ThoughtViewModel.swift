//
//  ThoughtViewModel.swift
//  rethought
//
//  Created by Dev on 12/8/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

public class ThoughtViewModel {
    private let thought: Thought
    
    public init(_ thought: Thought) {
        self.thought = thought
    }
    
    public var title: String {
        return thought.title
    }
    
    public var entryCount: Int {
        return thought.entries.count
    }
    public var entries: [Entry] {
        return thought.entries
    }
    
}
