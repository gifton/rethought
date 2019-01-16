//
//  HomeViewModel.swift
//  rethought
//
//  Created by Dev on 01/15/19.
//  Copyright © 2018 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewModel: DashboardViewModelDelegate {
    func getRecentEntries() -> EntryPreview {
        return EntryPreview(entry: Entry(title: "FWK"))
    }
    
    func getThoughts() -> [DashboardThought] {
        var thoughts = [DashboardThought]()
        for thought in self.thoughts {
            let thoughter = DashboardThought(thought: thought)
            thoughts.append(thoughter)
        }
        return thoughts
    }
    
    func getQuoteOfTheDay() -> QuoteOfTheDayElement {
        let url: URL = URL(string: "http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1")!
        let qotd = try! QuoteOfTheDayElement(fromURL: url)
        return qotd
    }
    
    private var viewDelegate: HomeViewControllerDelegate?
    
    private var thoughts: [Thought]
    private var entries: [Entry] = []
    
    init(thoughts: [Thought]) {
        self.thoughts = thoughts
        for thought in thoughts {
            for entry in thought.entries{ self.entries.append(entry) }
        }
    }
}

extension DashboardViewModel {
    func getReccomendedThought() -> ThoughtPreviewLarge {
        let thoughtPreview: ThoughtPreviewLarge = {
            guard let thought: Thought = self.thoughts.last else { return ThoughtPreviewLarge.init() }
            let tp = ThoughtPreviewLarge(icon: thought.icon, createdAt: "\(thought.date)", thoughtID: thought.ID, entryCount: thought.entryCount, title: thought.title)
            self.viewDelegate?.dataIsLoaded()
            return tp
        }()
        return thoughtPreview
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
}
