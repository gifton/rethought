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
    func getReccomendedThought() -> [ThoughtPreviewLarge] {
        if thoughts.count <= 0 {
            let thoughtPreview = ThoughtPreviewLarge()
            return [thoughtPreview, thoughtPreview]
        }
        var previews = [ThoughtPreviewLarge]()
        for thought in thoughts {
            let largePreview = ThoughtPreviewLarge(icon: thought.icon, createdAt: String(describing: thought.date), thoughtID: thought.ID, entryCount: thought.entryCount, title: thought.title)
            previews.append(largePreview)
        }
        return previews
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
    public var thoughts: [Thought]
    func createNew(_ thought: Thought) {
        print ("added \(thought) to db")
    }
    func destroy(_ thoughtID: Thought) {
        print ("deleted \(thoughtID)")
    }
    
}
