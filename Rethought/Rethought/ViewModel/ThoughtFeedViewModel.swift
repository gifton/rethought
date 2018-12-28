//
//  ThoughtViewModel.swift
//  rethought
//
//  Created by Dev on 12/28/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtFeedViewModel: ThoughtFeedModelDelegate {
    init(thoughts: [Thought]) {
        self.thoughts = thoughts
    }
    
    func update(_ data: Any, component: ThoughtComponent, id: String) {
        print ("updated \(id)")
    }
    func getEntries(for thoughtID: String) -> [Entry] {
        let thought = self.retrieve(thoughtID)
        return thought.entries
    }
    func getSimilarThoughts(for thoughtID: String) -> [ThoughtPreviewSmall] {
        let thought = ThoughtPreviewSmall(icon: "💻", lastEdited: "2 days ago", relatedThought: "something", itemCount: 2)
        return [thought, thought]
    }
    func retrieve(_ thoughtID: String) -> Thought {
        return thoughts.filter{ $0.ID == thoughtID }.first ?? Thought.init()
    }
    func getThoughtName(_ thoughtID: String) -> String {
        return thoughts.filter{ $0.ID == thoughtID}.first!.title
    }
    public var thoughts: [Thought]
    func createNew(_ thought: Thought) {
        print ("added \(thought) to db")
    }
    func destroy(_ thoughtID: Thought) {
        print ("deleted \(thoughtID)")
    }
    
}
