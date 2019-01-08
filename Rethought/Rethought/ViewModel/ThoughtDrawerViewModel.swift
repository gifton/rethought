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
        print("we are saved!")
    }
    
    func buildRecent(string input: Date) -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = true
            formatter.formattingContext = .standalone
            return formatter
        }()
        
        return "last edit: \(dateFormatter.string(from: thought.lastEdited))"
    }
}

extension ThoughtDrawerViewModel: DrawerObjectFactory {
    func convertToDrawerObject(_ view: UIView, availableIn states: [DrawerState]) -> DrawerObject {
        let obj = DrawerObject(view: view, availableIn: states)
        
        return obj
    }
}

