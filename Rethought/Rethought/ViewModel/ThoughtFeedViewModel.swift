//
//  ThoughtViewModel.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtFeedViewModel: ThoughtFeedViewModelDelegate {
    
    //thoughtFeedViewModel is fed thoughts, outputs all necesarry data
    required init(thoughts: [Thought]) {
        self.thoughts = thoughts
    }
    func retrieve(_ thoughtID: String) -> Thought {
        return thoughts.filter{ $0.ID == thoughtID }.first ?? Thought.init()
    }
    func retrieveThoughtPreview(_ thoughtID: String) -> ThoughtPreviewLarge {
        let thought = thoughts.filter{ $0.ID == thoughtID }.first ?? Thought.init()
        let preview = ThoughtPreviewLarge(icon: thought.icon, createdAt: String(describing: thought.date), thoughtID: thoughtID, entryCount: thought.entryCount, title: thought.title)
        return preview
    }
    func getThoughtName(_ thoughtID: String) -> String {
        return thoughts.filter{ $0.ID == thoughtID}.first!.title
    }
    private var thoughts: [Thought]
    
    public var allThoughts: [Thought] {
        get {
            return self.thoughts
        }
    }
}
