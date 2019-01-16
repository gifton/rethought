//
//  HomeViewModel.swift
//  rethought
//
//  Created by Dev on 12/10/18.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel: HomeViewModelDelegate {
    
    var viewDelegate: HomeViewControllerDelegate?
    func createNew(_ thought: Thought) {
        print ("created new thought from: \(thought)")
    }
    func destroy(_ thought: Thought) {
        print ("destroyed thought from: \(thought.ID)")
    }
    func update(_ thought: Thought) {
        print ("updated thought from: \(thought)")
    }
    var thoughts: [Thought]
    
    var entries: [Entry] = []
    
    init(thoughts: [Thought]) {
        self.thoughts = thoughts
        for thought in thoughts {
            for entry in thought.entries{self.entries.append(entry)}
        }
    }
}

extension HomeViewModel {
    func getReccomendedThought() -> ThoughtPreviewLarge {
        let thoughtPreview: ThoughtPreviewLarge = {
            guard let thought: Thought = self.thoughts.last else { return ThoughtPreviewLarge.init() }
            let tp = ThoughtPreviewLarge(icon: thought.icon, createdAt: "\(thought.date)", thoughtID: thought.ID, entryCount: thought.entryCount, title: thought.title)
            self.viewDelegate?.dataIsLoaded()
            return tp
        }()
        return thoughtPreview
    }
    func getRecentThoughts() -> [ThoughtPreviewSmall] {
        var previews: [ThoughtPreviewSmall] = []
        for thought in self.thoughts {
            let preview = ThoughtPreviewSmall(icon: thought.icon, lastEdited: thought.lastEdited, relatedThought: thought.ID, itemCount: thought.entries.count)
            previews.append(preview)
        }
        self.viewDelegate?.dataIsLoaded()
        return previews
    }
    func getRecentEntries() -> [EntryPreview] {
        var recentEntries = [EntryPreview]()
        for (count, entry) in self.entries.enumerated() {
            if count == 25 {
                break
            }
            let entryPrev = EntryPreview(entry: entry)
            recentEntries.append(entryPrev)
        }
        return recentEntries
    }
    func retrieve(thought thoughtID: String) -> Thought {
        return thoughts.filter{ $0.ID == thoughtID }.first ?? Thought.init()
    }
    func retrieve(entry entryID: String) -> Entry {
        return entries.filter{ $0.id == entryID }.first ?? Entry.init(title: "Not available")
    }
    func getThoughtName(_ thoughtID: String) -> String {
        let filteredThoughts = thoughts.filter{ $0.ID == thoughtID}
        if filteredThoughts.isEmpty {
            return "NOT AVAILABLE"
        } else {
            let output = filteredThoughts.first!
            return output.title
        }
    }
    func getMostrecentThought() -> Thought {
        let recentThoughtPreview = self.getRecentThoughts().first!
        let thought = self.retrieve(thought: recentThoughtPreview.thoughtID)
        return thought
    }
}
