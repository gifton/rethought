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
    
    init(thoughts: [Thought]) {
        self.thoughts = thoughts
    }
}

extension HomeViewModel {
    func getReccomended() -> ThoughtPreviewLarge {
        let thoughtPreview: ThoughtPreviewLarge = {
            guard let thought: Thought = self.thoughts.last else { return ThoughtPreviewLarge.init() }
            let tp = ThoughtPreviewLarge(icon: thought.icon, createdAt: "\(thought.date)", relatedThought: thought.ID, entryCount: thought.entryCount, title: thought.title)
            self.viewDelegate?.dataIsLoaded()
            return tp
        }()
        return thoughtPreview
    }
    func getRecent() -> [ThoughtPreviewSmall] {
        var previews: [ThoughtPreviewSmall] = []
        for thought in self.thoughts {
            let preview = ThoughtPreviewSmall(icon: thought.icon, lastEdited: "\(thought.lastEdited)", relatedThought: thought.ID)
            previews.append(preview)
        }
        self.viewDelegate?.dataIsLoaded()
        return previews
    }
}


