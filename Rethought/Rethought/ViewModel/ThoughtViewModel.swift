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
    private let thoughts: [Thought]
    
    public init(_ thoughts: [Thought]) {
        self.thoughts = thoughts
    }
    
    public var thoughtList: [Thought] {
        return thoughts
    }
    
    public func getEntriesfor(_ thought: Int) -> [Entry] {
        return thoughts[thought].entries
    }
    
}
