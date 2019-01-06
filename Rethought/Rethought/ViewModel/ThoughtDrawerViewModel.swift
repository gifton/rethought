//
//  ThoughtDrawerViewModel.swift
//  rethought
//
//  Created by Dev on 1/5/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class ThoughtDrawerViewModel {
    
    //THoughtDrawerViewModel is fed reccomended thought, saves data
    required init(recentThought: Thought) {
        self.thought = recentThought
    }
    
    private var thought: Thought
    
}

extension ThoughtDrawerViewModel: ThoughtDrawerViewModelDelegate {
    func save(new thought: Thought) {
        print ("saved context: \(thought)")
    }
    
    func createThought(title: String, description: String?) {
        print("created thought \(title)")
//        let thought = Thought
    }
    
    func save(new thought: ThoughtDrawerViewModel, with: Entry) {
        <#code#>
    }
    
    
}
